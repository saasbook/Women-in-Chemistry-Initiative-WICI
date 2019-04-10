class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.string :location
      t.string :tickets

      t.timestamps
    end

    create_table :guests do |t|
      t.has_many :events, index: true
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :event
  end
end
