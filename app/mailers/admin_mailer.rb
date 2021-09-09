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

end
