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

ActiveRecord::Schema.define(version: 20161019181557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "map_id"
    t.string   "floor_plan"
    t.string   "thumbnail"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.float    "width",       null: false
    t.float    "height",      null: false
    t.index ["map_id"], name: "index_areas_on_map_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "map_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "role",         default: 0,     null: false
    t.boolean  "accepted",     default: false
  end

  create_table "map_memberships", force: :cascade do |t|
    t.integer  "map_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "role",       default: 0, null: false
    t.index ["map_id"], name: "index_map_memberships_on_map_id", using: :btree
    t.index ["user_id"], name: "index_map_memberships_on_user_id", using: :btree
  end

  create_table "maps", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "license"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_maps_on_user_id", using: :btree
  end

  create_table "pins", force: :cascade do |t|
    t.float    "x"
    t.float    "y"
    t.string   "description"
    t.integer  "area_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["area_id"], name: "index_pins_on_area_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name",                              default: ""
    t.string   "authentication_token",   limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "areas", "maps"
  add_foreign_key "map_memberships", "maps"
  add_foreign_key "map_memberships", "users"
end
