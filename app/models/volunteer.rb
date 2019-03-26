class Volunteer < ApplicationRecord
  validates_format_of :name, with: /\A[^0-9`!@#\$%\^&*+_=]+\s[^0-9`!@#\$%\^&*+_=]+\z/, on: :create, message: "should have format: Firstname Lastname"
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
end
