class Assignment < ApplicationRecord
  belongs_to :volunteer
  belongs_to :task

  validates :task_id, :volunteer_id, presence: true
  validates_uniqueness_of :volunteer_id, scope: :task_id
end
