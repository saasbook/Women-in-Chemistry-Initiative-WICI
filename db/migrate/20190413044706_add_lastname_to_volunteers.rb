class AddLastnameToVolunteers < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :lastname, :string
  end
end
