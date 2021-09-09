class AdminMailer < ApplicationMailer

  def future_cook(cook)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @cook = cook 
    @user = User.find_by(id: @cook.user_id)

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://cookadom-staging.herokuapp.com/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

end
