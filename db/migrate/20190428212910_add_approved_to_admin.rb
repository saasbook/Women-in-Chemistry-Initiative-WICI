class AddApprovedToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :approved, :boolean, :default => false, :null => false
    add_index  :admins, :approved
  end
end
