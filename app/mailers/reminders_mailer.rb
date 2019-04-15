class RemindersMailer < ApplicationMailer

  def remind_guest(guest, event)
    @greeting = "Hello"
    @body = "You have the WICI #{event.name} event, on #{event.date}, at #{event.location}"
    mail to: guest.mail, from: "wiciberkeley@gmail.com"
  end
end
