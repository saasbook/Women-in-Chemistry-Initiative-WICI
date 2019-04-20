
Given /I am logged in as (?:a|an) ([^\s"]*)(?: named "([^"]*)")?/ do |user,name|
  if !name.nil?
    name = name.split
    fname = name[0]
    lname = name[1]
  end
  fname ||= "Testing"
  lname ||= "Man"
  email = "#{fname}@#{lname}.net"
  password = '123456'
  user.classify.constantize.new(email: email, firstname: fname, lastname: lname, password: password, password_confirmation: password).save!

  visit "/#{user}s/sign_in"
  fill_in "#{user}_email", :with => email
  fill_in "#{user}_password", :with => password
  click_button "Log in"
end

Given /the following volunteers exist/ do |volunteers_table|
  volunteers_table.hashes.each do |volunteer|
    volunteer[:password_confirmation] = volunteer[:password]
    new_volunteer = Volunteer.new(volunteer)
    new_volunteer.save!
  end
end

Given "{string} is a volunteer for {string}" do |name, taskname|\
  user = Volunteer.find_by_firstname(name)
  task = Task.find_by_name(taskname)
  assigned = Assignment.new(volunteer_id: user.id, task_id: task.id)
  assigned.save!
end

