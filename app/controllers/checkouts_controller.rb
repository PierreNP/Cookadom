class CheckoutsController < ApplicationController
  QUANTITY = 1

   def create
    @cart = Cart.find_by(user_id: current_user.id, status: 2)
    if current_user.addresses.first == nil
      redirect_to edit_user_path(current_user.id)
      flash[:error] = "Veuillez renseigner une adresse de livraison avant de valider votre commande."
    else
      @total = @cart.total_price
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
          {
            name: 'Rails.Stripe.Checkout',
            amount: @total,
            currency: 'eur',
            quantity: QUANTITY      
          }
        ],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
      )

      respond_to do |format|
        format.js
      end
    end
  end

  def success
    @cart = Cart.find_by(user_id: current_user.id, status: 2)
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    UserMailer.paid_order(current_user, @cart).deliver_now
    AdminMailer.paid_order(current_user, @cart).deliver_now
    CookMailer.paid_order(@cart).deliver_now
    @cart.update(status: 3)    
    @today = DateTime.now
    @deliver = @cart.delivery_date
    @diff = @deliver.to_time.to_i - @today.to_time.to_i
    UserMailer.deliver_order_today(current_user, @cart).deliver_later(wait: @diff - 84600)
    
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
end
