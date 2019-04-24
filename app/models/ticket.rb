class Ticket < ApplicationRecord
  belongs_to :guest
  validates :code
end
