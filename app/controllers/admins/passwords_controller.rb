# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  include Accessible
end
