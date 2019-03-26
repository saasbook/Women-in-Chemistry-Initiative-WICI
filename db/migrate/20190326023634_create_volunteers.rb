class CreateVolunteers < ActiveRecord::Migration[5.1]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :email
      t.string :event_id

      t.timestamps
    end
  end
end
