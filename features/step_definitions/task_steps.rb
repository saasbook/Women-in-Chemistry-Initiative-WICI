


Given /for (.*) the following tasks exist/ do |event, tasks_table|
  tasks_table.hashes.each do |task|
    event = Event.find_by_name(event)
    task["event_id"] = event.id
    new_task = Task.new(task)
    new_task.save!
  end
end

Then /(.*) tasks should exist/ do |n_seeds|
  Task.count.should be n_seeds.to_i
end

When /I edit (.*) to/ do |task, tasks_table|
  tasks_table.hashes.each do |new_task|
    task = Task.find_by_name(task)
    new_task["event_id"] = task.event_id
    task.update(new_task)
    task.save!
  end
end
