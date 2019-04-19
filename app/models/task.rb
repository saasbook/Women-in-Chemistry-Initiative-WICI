class Task < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :volunteers, :through => :assignments
  belongs_to :event

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :event_id


  # This allows volunteers to sign up for events without a specific task.
  # We may decide to remove this later, as we can stub tasks once they are done.

end
