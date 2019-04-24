class ChangeTicketsToBoolean < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :tickets, :boolean
  end
end
