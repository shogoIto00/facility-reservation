class CreateTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :timeslots do |t|
      t.string :day_of_the_week
      t.time :time_start
      t.time :time_finish

      t.timestamps
    end
  end
end
