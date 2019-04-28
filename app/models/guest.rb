class Guest < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :event
  has_one :ticket, dependent: :destroy

  validates :firstname, :lastname, :occupation, :gender, :department, presence: true
  validates :email, presence: true, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validate :check_capacity

  def check_capacity
    unless event.guests.count < event.capacity
      errors.add(:capacity, "Event is full.")
    end
  end

  def self.generate_qr_code(url)
    RQRCode::QRCode.new(url).as_png
  end

  def generate_code
    ticket.generate_code
  end
end
