Given /^I am logged in as admin$/ do
  email = 'testing@man.net'
  password = 'secretpass'
  Admin.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/admins/sign_in'
  fill_in "admin_email", :with => email
  fill_in "admin_password", :with => password
  click_button "Log in"

end
