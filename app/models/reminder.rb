class Reminder
  TIME_12H_FORMAT = /\A(1[0-2]|0?[1-9]):[0-5][0-9]\s?(am|pm)\z/i
  validates :time, presence: true,
    format: { with: TIME_12H_FORMAT}
end
