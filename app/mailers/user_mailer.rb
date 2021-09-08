class UserMailer < ApplicationMailer
 
    def welcome_email(user)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user 
  
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'https://cookadom-staging.herokuapp.com/' 
  
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
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

        @url  = "https://cookadom-staging.herokuapp.com/users/#{@user.id}"

        mail(to: @user.email, subject: 'Commande validée !')
    end

end
