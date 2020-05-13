class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
      t.string :access
      t.binary :photo

      t.timestamps
    end
  end
end
