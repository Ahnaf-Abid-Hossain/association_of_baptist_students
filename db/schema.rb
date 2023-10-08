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

ActiveRecord::Schema[7.0].define(version: 2023_10_03_172256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumnis", force: :cascade do |t|
    t.string "alum_first_name"
    t.string "alum_last_name"
    t.string "alum_email"
    t.string "alum_ph_num"
    t.integer "alum_class_year"
    t.string "alum_job_field"
    t.string "alum_location"
    t.string "alum_status"
    t.string "alum_major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.decimal "price"
    t.date "published_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "label"
    t.string "url"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.date "date"
    t.bigint "alumni_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumni_id"], name: "index_meeting_notes_on_alumni_id"
  end

  create_table "prayer_requests", force: :cascade do |t|
    t.string "request"
    t.string "status"
    t.bigint "alumni_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumni_id"], name: "index_prayer_requests_on_alumni_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "meeting_notes", "alumnis"
  add_foreign_key "prayer_requests", "alumnis"
end
