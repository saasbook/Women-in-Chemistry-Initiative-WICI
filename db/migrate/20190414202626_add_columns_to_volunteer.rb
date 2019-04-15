class AddColumnsToVolunteer < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :firstname, :string
    add_column :volunteers, :lastname, :string
  end
end
