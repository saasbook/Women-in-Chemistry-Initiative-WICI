class Guest < ApplicationRecord
  belongs_to :event
  has_one :ticket
  validates :firstname, :lastname, :occupation, :gender, :department, presence: true
  validates :email, presence: true, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validate :check_capacity

  def check_capacity
    unless event.guests.count < event.capacity
      errors.add(:capacity, "Event is full.")
    end
  end
end
