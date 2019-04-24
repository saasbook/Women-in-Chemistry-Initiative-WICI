class RemindersMailer < ApplicationMailer
  def remind_guest(guest, event)
    @greeting = "Hello"
    @body = "You have the WICI #{event.name}, on #{event.date}, at #{event.location}"
    mail to: guest.email, from: "wiciberkeley@gmail.com", subject: "WICI Event Reminder"
  end

  def remind_task(volunteer, task)
    @greeting = "Hello"
    @body = "You have the task #{task.name}, due by #{task.deadline}."
    mail to: volunteer.email, from: "wiciberkeley@gmail.com", subject: "WICI Task Volunteer Reminder"
  end
end
