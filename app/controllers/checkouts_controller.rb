class CheckoutsController < ApplicationController
  QUANTITY = 1

   def create
    puts "%"*500
    puts current_user.addresses[0].class
    puts "%"*500
    if current_user.addresses[0] == nil
      redirect_to edit_user_path(current_user.id)
      flash[:error] = "Veuillez renseigner une adresse de livraison avant de valider votr commande."
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
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    # UserMailer.command_confirmation_email(current_user).deliver_now
    # AdminMailer.command_confirmation_email(current_user).deliver_now
    @cart.update(status: 2)
    Cart.create(user_id: current_user.id, status: 0)
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @cart.update(status: 1)
  end
end
