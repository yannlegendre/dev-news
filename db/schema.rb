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

ActiveRecord::Schema.define(version: 2019_10_04_114856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_themes", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "theme_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_article_themes_on_article_id"
    t.index ["theme_id"], name: "index_article_themes_on_theme_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img_url", default: "https://i-love-png.com/images/no-image_7279.png"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "meetup_themes", force: :cascade do |t|
    t.bigint "meetup_id", null: false
    t.bigint "theme_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meetup_id"], name: "index_meetup_themes_on_meetup_id"
    t.index ["theme_id"], name: "index_meetup_themes_on_theme_id"
  end

  create_table "meetups", force: :cascade do |t|
    t.string "title"
    t.string "host"
    t.string "address"
    t.datetime "date_time"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "upvotes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_upvotes_on_article_id"
    t.index ["user_id"], name: "index_upvotes_on_user_id"
  end

  create_table "user_meetups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meetup_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meetup_id"], name: "index_user_meetups_on_meetup_id"
    t.index ["user_id"], name: "index_user_meetups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_themes", "articles"
  add_foreign_key "article_themes", "themes"
  add_foreign_key "comments", "users"
  add_foreign_key "meetup_themes", "meetups"
  add_foreign_key "meetup_themes", "themes"
  add_foreign_key "upvotes", "articles"
  add_foreign_key "upvotes", "users"
  add_foreign_key "user_meetups", "meetups"
  add_foreign_key "user_meetups", "users"
end
