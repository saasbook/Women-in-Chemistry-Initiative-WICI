class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :speaker
      t.datetime :date
      t.string :location
      t.string :tickets

      t.timestamps
    end
  end
end
