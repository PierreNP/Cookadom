class CookMailer < ApplicationMailer
    
    def asking_to_become_cook(cook)

        @cook = cook 
        @user = User.find_by(id: @cook.user_id)

        @url  = 'https://cookadom-staging.herokuapp.com/' 

        mail(to: @user.email, subject: 'Demande prise en compte !') 

    end

    def answer_admin(cook)
        
        @cook = cook 
        @user = User.find_by(id: @cook.user_id)

        @url  = 'https://cookadom-staging.herokuapp.com/' 

        mail(to: @user.email, subject: 'Réponse à votre demande')

    end

    def cooking_to_do(cook)
        
        @cook = cook
        @user = User.find_by(id: @cook.user_id)

        @url  = 'https://cookadom-staging.herokuapp.com/' 

        mail(to: @user.email, subject: 'Vous avez reçu une commande à valider')
        
    end
end
