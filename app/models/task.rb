class Task < ApplicationRecord
  has_many :assignments
  has_many :volunteers, :through => :assignments
  has_one :event
end
