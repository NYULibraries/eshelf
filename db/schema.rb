# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151002172519) do

  create_table "locations", force: true do |t|
    t.integer  "record_id",   null: false
    t.string   "collection"
    t.string   "call_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "records", force: true do |t|
    t.string   "external_id",                        null: false
    t.string   "external_system",                    null: false
    t.integer  "user_id"
    t.integer  "tmp_user_id"
    t.text     "title",                              null: false
    t.text     "author"
    t.string   "format",                             null: false
    t.text     "url",                                null: false
    t.text     "data",            limit: 2147483647, null: false
    t.text     "title_sort",                         null: false
    t.string   "content_type"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "records", ["tmp_user_id", "external_system", "external_id"], name: "index_records_on_tmp_user_id_and_external_system_and_external_id", unique: true, using: :btree
  add_index "records", ["user_id", "external_system", "external_id"], name: "index_records_on_user_id_and_external_system_and_external_id", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tmp_users", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.string   "email",                           null: false
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "refreshed_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "mobile_phone"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "session_id"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.string   "last_request_at"
    t.string   "current_login_at"
    t.string   "last_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.text     "user_attributes"
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider",           default: "", null: false
    t.string   "aleph_id"
    t.string   "institution_code"
    t.string   "patron_status"
  end

  add_index "users", ["username", "provider"], name: "index_users_on_username_and_provider", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
