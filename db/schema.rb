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

ActiveRecord::Schema[7.0].define(version: 2023_10_30_092516) do
  create_table "appointments", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
    t.integer "time_slot_id"
    t.string "description"
    t.string "status", default: "booked", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["time_slot_id"], name: "index_appointments_on_time_slot_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "day_of_week", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "open", null: false
    t.index ["doctor_id"], name: "index_time_slots_on_doctor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "appointments", "time_slots"
  add_foreign_key "appointments", "users", column: "patient_id"
  add_foreign_key "time_slots", "users", column: "doctor_id"
end
