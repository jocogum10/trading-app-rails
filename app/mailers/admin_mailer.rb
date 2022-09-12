class AdminMailer < ApplicationMailer
    default from: ENV['ADMIN_EMAIL']
    def welcome_email
        @user = params[:user]
        @url = "http://localhost:3000/users/confirmation?confirmation_token=#{@user.confirmation_token}"
        mail(to: @user.email, subject: "Welcome to the Rails Trading App")
    end
    def verify_email
        @user = params[:user]
        @url = 'http://localhost:3000/'
        mail(to: @user.email, subject: "Verified user of the Rails Trading App")
    end
end
