# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_06_090103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "password_digest"
    t.string "string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phonenumber"
    t.index ["phonenumber"], name: "index_admins_on_phonenumber"
  end

  create_table "normalusers", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.string "accounttype"
    t.string "phonenumber"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.integer "pid"
    t.index ["created_at"], name: "index_normalusers_on_created_at"
    t.index ["email"], name: "index_normalusers_on_email"
    t.index ["phonenumber"], name: "index_normalusers_on_phonenumber"
    t.index ["pid"], name: "index_normalusers_on_pid"
  end

  add_foreign_key "normalusers", "normalusers", column: "pid"
end
