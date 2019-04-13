class AddFirstnameToVolunteers < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :firstname, :string
  end
end
