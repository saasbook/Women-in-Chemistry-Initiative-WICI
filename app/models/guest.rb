class Guest < ApplicationRecord
  belongs_to :event
  validates :firstname, :lastname, presence: true
  validates :email, presence: true, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
end
