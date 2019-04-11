When /^I fill out the form with the following attributes:$/ do |table|
  criteria = table.rows_hash.each do |field, value|
      fill_in field, :with => value
  end
  step 'I press "submit"'
end

Then /(.*) guests should exist/ do |n_seeds|
  Guest.count.should be n_seeds.to_i
end

Then /^I save and open page/ do
  save_and_open_page
end