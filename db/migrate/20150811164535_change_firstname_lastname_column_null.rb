class ChangeFirstnameLastnameColumnNull < ActiveRecord::Migration
  def up
    change_column :users, :firstname, :string, null: true
    change_column :users, :lastname, :string, null: true
  end
  def down
    change_column :users, :firstname, :string, null: false
    change_column :users, :lastname, :string, null: false
  end
end
