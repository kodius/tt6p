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

ActiveRecord::Schema.define(version: 2018_09_16_225429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "weight", precision: 15, scale: 2
    t.datetime "log_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "body_fat", precision: 15, scale: 2
    t.decimal "calories", precision: 15, scale: 2
    t.boolean "success"
    t.string "image"
    t.integer "week_num"
    t.integer "month_num"
    t.integer "year_num"
    t.index ["user_id", "month_num"], name: "index_measurements_on_user_id_and_month_num"
    t.index ["user_id", "week_num"], name: "index_measurements_on_user_id_and_week_num"
    t.index ["user_id", "year_num"], name: "index_measurements_on_user_id_and_year_num"
  end

  create_table "nutritions", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "log_date"
    t.string "meal"
    t.decimal "calories", precision: 15, scale: 2
    t.decimal "fat", precision: 15, scale: 2
    t.decimal "protein", precision: 15, scale: 2
    t.decimal "carbohydrates", precision: 15, scale: 2
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "weight", precision: 15, scale: 2
    t.decimal "body_fat", precision: 15, scale: 2
    t.decimal "target_body_fat", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "height", precision: 15, scale: 2
    t.integer "age"
    t.string "gender"
    t.string "activity_level"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
