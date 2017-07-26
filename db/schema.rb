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

ActiveRecord::Schema.define(version: 20170726002443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", id: :serial, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.string "spotify_id", null: false
    t.string "name", null: false
    t.string "image_url"
    t.integer "number_of_tracks", null: false
    t.date "released_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "metadata"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["spotify_id"], name: "index_albums_on_spotify_id"
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "spotify_id", null: false
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "disabled_at"
    t.index ["disabled_at"], name: "index_artists_on_disabled_at"
    t.index ["spotify_id"], name: "index_artists_on_spotify_id"
  end

  create_table "artists_users", id: :serial, force: :cascade do |t|
    t.integer "artist_id"
    t.integer "user_id"
    t.index ["artist_id"], name: "index_artists_users_on_artist_id"
    t.index ["user_id"], name: "index_artists_users_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "album_id"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_notifications_on_album_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "artists_users", "artists"
  add_foreign_key "artists_users", "users"
  add_foreign_key "notifications", "albums"
  add_foreign_key "notifications", "users"
end
