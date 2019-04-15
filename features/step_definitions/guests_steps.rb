When /^I fill out the form with the following attributes:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
      fill_in field, :with => value
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

Then /(.*) guests should exist/ do |n_seeds|
  Guest.count.should be n_seeds.to_i
end

Then /^I save and open page/ do
  save_and_open_page
end