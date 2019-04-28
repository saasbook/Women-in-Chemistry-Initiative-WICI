class AddApprovedToVolunteer < ActiveRecord::Migration[5.1]
  def change
    add_column :volunteers, :approved, :boolean, :default => false, :null => false
    add_index  :volunteers, :approved
  end
end
