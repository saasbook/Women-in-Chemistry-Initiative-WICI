class RemoveTaskIdFromVolunteers < ActiveRecord::Migration[5.1]
  def change
    remove_column :volunteers, :task_id, :integer
  end
end
