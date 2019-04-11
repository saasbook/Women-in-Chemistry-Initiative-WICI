class AddCapacityToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :capacity, :integer
  end
end
