class UserMailer < ApplicationMailer
  def registered_event_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'WICI Event Registration Confirmed')
  end
end
