class ChangeStringFieldsToTextOnRecords < ActiveRecord::Migration
  def up
    change_column :records, :author, :text
    change_column :records, :title, :text
    change_column :records, :title_sort, :text
  end
  def down
    change_column :records, :author, :string
    change_column :records, :title, :string
    change_column :records, :title_sort, :string
  end
end
