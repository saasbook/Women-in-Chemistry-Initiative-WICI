class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.integer :task_id
      t.integer :volunteer_id

      t.timestamps
    end
  end
end
