Given /the following guests exist/ do |guests_table|
  guests_table.hashes.each do |guest|
    new_guest = Guest.new(guest)
    new_guest.save!
  end
end

When /^I fill out the form with the following attributes:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
      fill_in field, :with => value
  end
end

Then /(.*) guests should exist/ do |n_seeds|
  Guest.count.should be n_seeds.to_i
end