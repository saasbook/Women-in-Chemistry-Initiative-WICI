When /^I submit the form with the following attributes:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
  	if field.include?('[')
		select(value, :from => field)
	else
     	fill_in field, :with => value
  	end
  end
  step 'I press "submit"'
end


Given /the following guests exist/ do |guests_table|
  @event = Event.find(1)
  guests_table.hashes.each do |guest|
    new_guest = Guest.new(guest)
    new_guest.save!
  end
end

Given /^I select the following attributes:$/ do |demo_table|
	criteria = demo_table.rows_hash.each do |field,value|
		select(value, :from => field)
	end
end

Then /(.*) guests should exist/ do |n_seeds|
  Guest.count.should be n_seeds.to_i
end

Then /^I save and open page/ do
  save_and_open_page
end