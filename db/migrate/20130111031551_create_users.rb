class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :mobile_phone
      t.string :crypted_password
      t.string :password_salt
      t.string :session_id
      t.string :persistence_token
      t.integer :login_count
      t.string :last_request_at
      t.string :current_login_at
      t.string :last_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.text :user_attributes, limit: 4294967295
      t.datetime :refreshed_at

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
