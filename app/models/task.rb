class Task < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :volunteers, :through => :assignments
  belongs_to :event

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :event_id

end
