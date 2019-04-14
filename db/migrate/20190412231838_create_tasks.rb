class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :event, index: true

      t.timestamps
    end
  end
end
