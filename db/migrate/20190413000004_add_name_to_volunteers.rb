class AddNameToVolunteers < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :name, :string
  end
end
