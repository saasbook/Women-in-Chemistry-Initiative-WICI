class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :assignments, through: :tasks, dependent: :destroy
  validates :name, :date, :location, :capacity, presence: true

  def self.past_events
    Event.where("date < ?", Date.current).order(date: :desc)
  end
  def self.future_events
    Event.where("date > ?", Date.current).order(:date)
  end
end
