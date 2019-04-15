module ControllerMacros
  def login_volunteer
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:volunteer]
        volunteer = FactoryGirl.create(:volunteer)
        sign_in volunteer
     end
  end

  def login_admin
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        admin = FactoryGirl.create(:admin)
        sign_in admin
     end
  end
end
