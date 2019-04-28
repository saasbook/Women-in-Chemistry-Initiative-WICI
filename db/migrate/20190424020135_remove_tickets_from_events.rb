class RemoveTicketsFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :tickets
  end
end
