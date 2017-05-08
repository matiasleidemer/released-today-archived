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

ActiveRecord::Schema.define(version: 20170508024705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "artist_id",        null: false
    t.string   "spotify_id",       null: false
    t.string   "name",             null: false
    t.string   "image_url",        null: false
    t.integer  "number_of_tracks", null: false
    t.date     "released_at",      null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id", using: :btree
    t.index ["spotify_id"], name: "index_albums_on_spotify_id", using: :btree
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "spotify_id", null: false
    t.json     "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_id"], name: "index_artists_on_spotify_id", using: :btree
  end

  create_table "artists_users", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "user_id"
    t.index ["artist_id"], name: "index_artists_users_on_artist_id", using: :btree
    t.index ["user_id"], name: "index_artists_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                      null: false
    t.string   "provider",                   null: false
    t.string   "uid",                        null: false
    t.json     "metadata"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "admin",      default: false, null: false
    t.string   "token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["token"], name: "index_users_on_token", using: :btree
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "artists_users", "artists"
  add_foreign_key "artists_users", "users"
end
