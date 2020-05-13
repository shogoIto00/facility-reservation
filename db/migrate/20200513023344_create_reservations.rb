class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :allocation, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
