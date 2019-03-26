Given /the following volunteers exist/ do |volunteers_table|
  volunteers_table.hashes.each do |volunteer|
    volunteer[:event_id] = Event.find_by_name(volunteer[:event]).id
    volunteer.delete("event")
    new_volunteer = Volunteer.new(volunteer)
    new_volunteer.save!
  end
end

