class CreateAllocations < ActiveRecord::Migration[5.2]
  def change
    create_table :allocations do |t|
      t.references :room, foreign_key: true
      t.references :timeslot, foreign_key: true
      t.string :status
      t.date :date

      t.timestamps
    end
  end
end
