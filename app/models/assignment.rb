class Assignment < ApplicationRecord
  validates :task_id, :volunteer_id, presence: true
  validates_uniqueness_of :volunteer_id, :scope => :task_id
  belongs_to :volunteer
  belongs_to :task

end
