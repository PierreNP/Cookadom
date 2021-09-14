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

    def paid_order(cart)
        
        @cart = cart
        @order_dishes = OrderDish.where(cart_id: @cart.id)
        @dishes = []

        @order_dishes.each do |order_dish|
            @dishes << Dish.find_by(id: order_dish.dish_id)
        end
        
        @cook = Cook.find_by(id: @dishes[0].cook_id)

        @url  = 'https://cookadom-staging.herokuapp.com/cook/dishes'

        mail(to: @cook.user.email, subject: 'La commande a été réglée, à vos fourneaux !')
        
    end

end
