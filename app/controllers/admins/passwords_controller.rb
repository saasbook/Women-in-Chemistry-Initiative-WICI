class Admins::PasswordsController < Devise::PasswordsController
  include Accessible
end
