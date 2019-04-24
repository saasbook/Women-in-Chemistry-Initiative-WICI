class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :code
      t.references :guest, foreign_key: true

      t.timestamps
    end
  end
end
