# frozen_string_literal: true

class Admins::ConfirmationsController < Devise::ConfirmationsController
  include Accessible
end
