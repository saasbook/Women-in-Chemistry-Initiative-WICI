class AddDepartmentToGuests < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :department, :string
  end
end
