Given /the following guests exist/ do |guests_table|
  guests_table.hashes.each do |guest|
    new_guest = Guest.new(guest)
    new_guest.save!
  end
end

Then /(.*) guests should exist/ do |n_seeds|
  Guest.count.should be n_seeds.to_i
end