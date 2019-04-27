class AddTicketBooleanToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :has_tickets, :boolean
  end
end
