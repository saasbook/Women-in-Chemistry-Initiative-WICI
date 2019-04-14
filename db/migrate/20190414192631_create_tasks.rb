class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :deadline
      t.references :event, index: true
      t.timestamps
    end
  end
end
