class RemindersMailer < ApplicationMailer
  def remind_guest(guest, event)
    @greeting = "Hello"
    @body = "You have the WICI #{event.name}, on #{event.date}, at #{event.location}"
    mail to: guest.email, from: "wiciberkeley@gmail.com", subject: "WICI Event Reminder"
  end
end
