class Task < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :volunteers, :through => :assignments
  belongs_to :event

  validates :name, presence: true

  def self.all_tasks(id)
    Task.where(:event_id => id).order(deadline: :desc)
  end


  # This allows volunteers to sign up for events without a specific task.
  # We may decide to remove this later, as we can stub tasks once they are done.
  def self.get_none_task(event)
    task = Task.find_by_name_and_event_id("Nothing", event.id)
    if task.nil?
      task = Task.new(name: "Nothing", event_id: event.id)
      task.save!
    end
    task
  end

end
