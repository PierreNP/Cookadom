class AdminMailer < ApplicationMailer

  def future_cook(cook)
    
    @cook = cook 
    @user = User.find_by(id: @cook.user_id)
    @admins = User.admin

    @url  = 'https://cookadom-staging.herokuapp.com/' 

    @admins.each do |admin|
      mail(to: admin.email, subject: 'Bienvenue chez nous !')      
    end

  end

  def paid_order(user, cart)

    @admins = User.admin
    @user = user   
    @cart = cart
    @order_dishes = OrderDish.where(cart_id: @cart.id)
    @dishes = []
    
    @order_dishes.each do |order_dish|
      @dishes << Dish.find_by(id: order_dish.dish_id)
    end

    @admins.each do |admin|
      mail(to: admin.email, subject: "Commande payée par #{@user.email} !")      
    end


  end

end
