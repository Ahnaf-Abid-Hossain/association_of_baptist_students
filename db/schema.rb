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

ActiveRecord::Schema[7.0].define(version: 2023_10_15_002449) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meeting_notes_on_user_id"
  end

  create_table "prayer_requests", force: :cascade do |t|
    t.string "request"
    t.string "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prayer_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_first_name"
    t.string "user_last_name"
    t.string "user_contact_email"
    t.string "user_ph_num"
    t.integer "user_class_year"
    t.string "user_job_field"
    t.string "user_location"
    t.string "user_status"
    t.string "user_major"
    t.integer "approval_status", default: 0
    t.boolean "is_contact_email_private", default: false
    t.boolean "is_ph_num_private", default: false
    t.boolean "is_class_year_private", default: false
    t.boolean "is_job_field_private", default: false
    t.boolean "is_location_private", default: false
    t.boolean "is_status_private", default: false
    t.boolean "is_major_private", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "meeting_notes", "users", on_delete: :cascade
  add_foreign_key "prayer_requests", "users", on_delete: :cascade
end
