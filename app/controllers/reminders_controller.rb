class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new
    for event in Events.future_events
      for guest in event.guests
        if @reminder.valid?
          #2 hours before event
          RemindersMailer.remind_guest(guest, event).deliver_later(wait_until: (event.time - 7200).seconds.from_now)
        else
          flash[:alert] = "Please make sure your event is valid!"
          redirect_to events_url
        end
      end
    end
  end


end
