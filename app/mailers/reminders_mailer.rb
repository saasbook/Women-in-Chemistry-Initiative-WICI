class RemindersMailer < ApplicationMailer
  def remind_guest(guest, event)
    @greeting = "Hello"
    @body = "You have the WICI #{event.name}, on #{event.date.strftime('%A, %b%e, at %l:%M %p')}, at #{event.location}"
    mail to: guest.email, from: "donotreplywici@gmail.com", subject: "WICI Event Reminder"
  end

  def confirm_guest(guest, event, qrcode)
    @greeting = "Hello"
    @body = "You are registered for the WICI #{event.name}, on #{event.date.strftime('%A, %b%e, at %l:%M %p')}, at #{event.location}"
    File.open("/tmp/qrcode.png", "wb") do |f|
      f.write qrcode
    end

    attachments['ticket.png'] = File.read("/tmp/qrcode.png")
    mail to: guest.email, from: "donotreplywici@gmail.com", subject: "WICI Event Confirmation"
  end

  def remind_task(volunteer, task)
    @greeting = "Hello"
    @body = "You have the task #{task.name}, due by #{task.deadline.strftime('%A, %b%e, at %l:%M %p')}."
    mail to: volunteer.email, from: "donotreplywici@gmail.com", subject: "WICI Task Volunteer Reminder"
  end
end
