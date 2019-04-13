class Task < ApplicationRecord
  has_many :assignments
  has_many :volunteers, :through => :assignments
  has_one :event

  # This allows volunteers to sign up for events without a specific task.
  # We may decide to remove this later, as we can stub tasks once they are done.
  def self.get_none_task(event)
    task = Task.find_by_title_and_event_id(:None, event) || Task.new(title: :None, event_id: event)
    task
  end
end
