Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
    new_event = Event.new(event)
    new_event.save!
  end
end

Then /(.*) events should exist/ do |n_seeds|
  Event.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  step %{I should see /.*#{e1}.*#{e2}/}
end
