class CreateLeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :leaders do |t|
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
