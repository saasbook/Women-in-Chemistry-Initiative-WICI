class AddTaskIdToVolunteers < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :task_id, :integer
  end
end
