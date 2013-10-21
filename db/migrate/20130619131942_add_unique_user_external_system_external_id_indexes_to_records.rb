class AddUniqueUserExternalSystemExternalIdIndexesToRecords < ActiveRecord::Migration
  def change
    add_index :records, [:user_id, :external_system, :external_id], unique: true
    add_index :records, [:tmp_user_id, :external_system, :external_id], unique: true
  end
end
