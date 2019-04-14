class Task < ApplicationRecord
  has_and_belongs_to_many :volunteers
  belongs_to :event
  validates :name, presence: true

  def self.all_tasks(event)
    Task.where(:event_id => event).order(deadline: :desc)
  end

end
