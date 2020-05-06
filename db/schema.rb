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

ActiveRecord::Schema.define(version: 2020_05_06_223515) do

  create_table "airports", force: :cascade do |t|
    t.string "code"
    t.integer "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["city_id"], name: "index_airports_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "destinations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planes", force: :cascade do |t|
    t.string "model"
    t.string "identifier"
    t.integer "year_made"
    t.boolean "available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "daily_cost"
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "plane_id", null: false
    t.integer "airport_id", null: false
    t.integer "plane_rating", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "rental_start"
    t.datetime "rental_end"
    t.datetime "rental_return"
    t.integer "rental_cost"
    t.index ["airport_id"], name: "index_rentals_on_airport_id"
    t.index ["plane_id"], name: "index_rentals_on_plane_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "airports", "cities"
  add_foreign_key "rentals", "airports"
  add_foreign_key "rentals", "planes"
  add_foreign_key "rentals", "users"
end
