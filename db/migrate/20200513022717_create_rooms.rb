class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :facility, foreign_key: true
      t.string :purpose
      t.integer :price
      t.integer :maximum_capacity

      t.timestamps
    end
  end
end
