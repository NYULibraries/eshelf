class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :record_id, null: false
      t.string :collection
      t.string :call_number

      t.timestamps
    end
  end
end
