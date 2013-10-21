class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :external_id, null: false
      t.string :external_system, null: false
      t.integer :user_id
      t.integer :tmp_user_id
      t.string :title, null: false
      t.string :author
      t.string :format, null: false
      t.text :url, null: false
      t.text :data, limit: 4294967295, null: false
      t.string :title_sort, null: false
      t.string :content_type

      t.timestamps
    end
  end
end
