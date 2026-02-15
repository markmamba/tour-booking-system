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

ActiveRecord::Schema[8.1].define(version: 2026_02_15_042446) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "identities_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.string "vehicle_plate_number"
    t.string "vehicle_type"
    t.index ["email"], name: "index_identities_users_on_email", unique: true
  end

  create_table "tours_bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "customer_email", null: false
    t.string "customer_name", null: false
    t.string "customer_whatsapp_line", null: false
    t.bigint "driver_id"
    t.string "dropoff_address"
    t.integer "duration_hours"
    t.string "flight_number"
    t.integer "luggage_count", default: 0
    t.integer "passenger_count", default: 1
    t.string "pickup_address", null: false
    t.datetime "pickup_datetime", null: false
    t.decimal "quoted_price", precision: 10, scale: 2
    t.string "service_type", null: false
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_tours_bookings_on_driver_id"
  end

  add_foreign_key "tours_bookings", "identities_users", column: "driver_id"
end
