module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
    def check_user
      if current_admin || current_volunteer
        flash.clear
        redirect_to(root_path)
      end
  end
end
