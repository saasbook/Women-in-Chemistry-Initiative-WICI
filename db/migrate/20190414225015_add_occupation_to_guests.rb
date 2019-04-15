class AddOccupationToGuests < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :occupation, :string
  end
end
