class Assignment < ApplicationRecord
  validates :task_id, :volunteer_id, :presence => true, :uniqueness => true
  belongs_to :volunteer
  belongs_to :task

  def name
    self.volunteer.name
  end
end
