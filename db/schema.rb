# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141221005324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cans", force: true do |t|
    t.integer "num_cans",        null: false
    t.string  "container",       null: false
    t.string  "pickup_time"
    t.string  "pickup_location", null: false
    t.integer "user_id",         null: false
  end

  create_table "donations", force: true do |t|
    t.string  "body",            null: false
    t.string  "pickup_time",     null: false
    t.string  "pickup_location", null: false
    t.integer "user_id",         null: false
  end

  create_table "greetings", force: true do |t|
    t.string  "body",    null: false
    t.integer "user_id", null: false
  end

  create_table "meals", force: true do |t|
    t.string  "name",            null: false
    t.integer "will_feed",       null: false
    t.string  "pickup_time"
    t.string  "pickup_location", null: false
    t.integer "user_id",         null: false
  end

  create_table "users", force: true do |t|
    t.string "name",            null: false
    t.string "phonenumber",     null: false
    t.text   "email",           null: false
    t.text   "password_digest"
  end

end
