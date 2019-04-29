
Given /I am logged in as (?:a|an)(\sunapproved)? ([^\s"]*)(?: named "([^"]*)")?/ do |unapproved,user,name|
  if !name.nil?
    name = name.split
    fname = name[0]
    lname = name[1]
  end
  fname ||= "Testing"
  lname ||= "Man"
  email = "#{fname}@#{lname}.net"
  password = '123456'
  approved = unapproved.nil?


  user.classify.constantize.new(email: email, firstname: fname, lastname: lname, approved: approved, password: password, password_confirmation: password).save!

  visit "/#{user}s/sign_in"
  fill_in "#{user}_email", :with => email
  fill_in "#{user}_password", :with => password
  click_button "Log in"
end

Given /the following volunteers exist/ do |volunteers_table|
  volunteers_table.hashes.each do |volunteer|
    volunteer[:password_confirmation] = volunteer[:password]
    volunteer[:approved] ||= true
    new_volunteer = Volunteer.new(volunteer)
    new_volunteer.save!
  end
end

Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    admin[:password_confirmation] = admin[:password]
    admin[:approved] ||= true
    new_admin = Admin.new(admin)
    new_admin.save!
  end
end

Given "{string} is a volunteer for {string}" do |name, taskname|\
  user = Volunteer.find_by_firstname(name)
  task = Task.find_by_name(taskname)
  assigned = Assignment.new(volunteer_id: user.id, task_id: task.id)
  assigned.save!
end


When /^I log in with the following attributes:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
    if field.include?('[')
    select(value, :from => field)
  else
      fill_in field, :with => value
    end
  end
  step 'I press "Log in"'
end

