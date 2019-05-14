class FixGuestNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :guests, :firstname, :first_name
    rename_column :guests, :lastname, :last_name
  end
end
