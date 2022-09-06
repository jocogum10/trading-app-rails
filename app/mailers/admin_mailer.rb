class AdminMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        @url = 'http://localhost:3000/'
        mail(to: @user.email, subject: "Welcome to the Rails Trading App")
    end
end
