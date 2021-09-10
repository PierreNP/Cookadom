class UserMailer < ApplicationMailer
 
    def welcome_email(user)
      @user = user 
  
      @url  = 'https://cookadom-staging.herokuapp.com/' 
  
      mail(to: @user.email, subject: 'Bienvenue chez nous !') 
    end

    def waiting_for_validation(user)
      @user = user 

      @url  = "https://cookadom-staging.herokuapp.com/users/#{@user.id}"

      mail(to: @user.email, subject: 'Commande en attente de validation !')

    end

    def validated_order(user, cook)
        @user = user 
        @cook = cook
        @cart = user.cart.find_by(status: 1)
        @url  = "https://cookadom-staging.herokuapp.com/cart/#{@cart.id}"

        mail(to: @user.email, subject: 'Commande validée !')
    end

end
