class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :task, foreign_key: true
      t.references :volunteer, foreign_key: true

      t.timestamps
    end
  end
end
