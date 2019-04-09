class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.contact_me.subject
  #
  def contact_me(message)
    @greeting = "Hi"
    # the body of the message that guest sent us.
    @body = message.body
    # the email address used to create the Message
    mail to: "wiciberkeley@gmail.com", from: message.email
  end
end
