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

ActiveRecord::Schema.define(version: 20170728192644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bar_reports", force: :cascade do |t|
    t.bigint "bar_id"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bar_id"], name: "index_bar_reports_on_bar_id"
    t.index ["report_id"], name: "index_bar_reports_on_report_id"
  end

  create_table "bar_tags", force: :cascade do |t|
    t.bigint "bar_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bar_id"], name: "index_bar_tags_on_bar_id"
    t.index ["tag_id"], name: "index_bar_tags_on_tag_id"
  end

  create_table "bars", force: :cascade do |t|
    t.bigint "neighborhood_id"
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "phone_number"
    t.float "beer_price"
    t.float "wine_price"
    t.float "cocktails_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "photo_id"
    t.string "start_day"
    t.string "end_day"
    t.time "start_hour"
    t.time "end_hour"
    t.index ["neighborhood_id"], name: "index_bars_on_neighborhood_id"
    t.index ["photo_id"], name: "index_bars_on_photo_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string "neighborhood_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bar_id"
    t.string "caption"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["bar_id"], name: "index_photos_on_bar_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "beer_price"
    t.integer "wine_price"
    t.integer "cocktails_price"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "img_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bar_reports", "bars"
  add_foreign_key "bar_reports", "reports"
  add_foreign_key "bar_tags", "bars"
  add_foreign_key "bar_tags", "tags"
  add_foreign_key "bars", "neighborhoods"
  add_foreign_key "bars", "photos"
  add_foreign_key "photos", "bars"
  add_foreign_key "photos", "users"
  add_foreign_key "reports", "users"
end
