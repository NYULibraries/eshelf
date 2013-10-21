class CreateTmpUsers < ActiveRecord::Migration
  def change
    create_table :tmp_users do |t|

      t.timestamps
    end
  end
end
