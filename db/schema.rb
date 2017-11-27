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

ActiveRecord::Schema.define(version: 20171127213705) do

  create_table "locations", force: :cascade do |t|
    t.integer  "record_id",   limit: 4,   null: false
    t.string   "collection",  limit: 255
    t.string   "call_number", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "records", force: :cascade do |t|
    t.string   "external_id",     limit: 255,        null: false
    t.string   "external_system", limit: 255,        null: false
    t.integer  "user_id",         limit: 4
    t.integer  "tmp_user_id",     limit: 4
    t.text     "title",           limit: 65535,      null: false
    t.text     "author",          limit: 65535
    t.string   "format",          limit: 255,        null: false
    t.text     "url",             limit: 65535
    t.text     "data",            limit: 4294967295, null: false
    t.text     "title_sort",      limit: 65535,      null: false
    t.string   "content_type",    limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "records", ["tmp_user_id", "external_system", "external_id"], name: "index_records_on_tmp_user_id_and_external_system_and_external_id", unique: true, using: :btree
  add_index "records", ["user_id", "external_system", "external_id"], name: "index_records_on_user_id_and_external_system_and_external_id", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tmp_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 255,                null: false
    t.string   "email",              limit: 255,                null: false
    t.string   "firstname",          limit: 255
    t.string   "lastname",           limit: 255
    t.datetime "refreshed_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "user_attributes",    limit: 65535
    t.integer  "sign_in_count",      limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.string   "provider",           limit: 255,   default: "", null: false
    t.string   "aleph_id",           limit: 255
    t.string   "institution_code",   limit: 255
    t.string   "patron_status",      limit: 255
  end

  add_index "users", ["username", "provider"], name: "index_users_on_username_and_provider", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
