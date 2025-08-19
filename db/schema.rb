# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_08_19_075724) do
  create_table "group_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id", "group_id"], name: "index_group_users_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individuals", force: :cascade do |t|
    t.string "identification_id"
    t.date "hunt_date"
    t.string "origin"
    t.string "species"
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "age_in_months"
    t.decimal "weight", precision: 5, scale: 2
    t.date "disassembling_date"
    t.date "processing_date"
    t.string "processing_facility"
    t.string "processor_name"
    t.string "hit_area"
    t.string "damaged_parts"
    t.string "blood_letting"
    t.string "cooling"
    t.string "travel_time"
    t.string "token"
    t.index ["token"], name: "index_individuals_on_token", unique: true
    t.index ["user_id"], name: "index_individuals_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "part", null: false
    t.decimal "weight"
    t.string "status", default: "stocked", null: false
    t.boolean "available"
    t.integer "individual_id", null: false
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_inventories_on_group_id"
    t.index ["individual_id"], name: "index_inventories_on_individual_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "shipment_inventories", force: :cascade do |t|
    t.integer "shipment_id", null: false
    t.integer "inventory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_shipment_inventories_on_inventory_id"
    t.index ["shipment_id"], name: "index_shipment_inventories_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "user_id"
    t.date "ship_date"
    t.string "customer"
    t.string "item"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "role", default: "user", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "individuals", "users"
  add_foreign_key "inventories", "groups"
  add_foreign_key "inventories", "individuals"
  add_foreign_key "inventories", "users"
  add_foreign_key "shipment_inventories", "inventories"
  add_foreign_key "shipment_inventories", "shipments"
end
