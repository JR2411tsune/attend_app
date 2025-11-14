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

<<<<<<< HEAD
ActiveRecord::Schema[7.2].define(version: 2025_10_24_024952) do
  create_table "attendances_tests", force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

=======
ActiveRecord::Schema[7.2].define(version: 2025_10_24_014911) do
>>>>>>> 93054bff29c5849eb0afe83cbc0e21dd269aa9a7
  create_table "lessons", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject"
    t.integer "period_number"
    t.date "date"
    t.integer "is_attendance"
    t.string "absence_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "testsumples", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "role"
    t.integer "attendance_count"
    t.integer "absence_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "student_no"
  end

  add_foreign_key "lessons", "users"
end
