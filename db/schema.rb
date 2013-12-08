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

ActiveRecord::Schema.define(version: 20131208182028) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.text     "instructions"
    t.text     "hints"
    t.integer  "track_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.text     "starting_content"
    t.integer  "user_id"
  end

  create_table "progresses", force: true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progresses", ["lesson_id"], name: "index_progresses_on_lesson_id"
  add_index "progresses", ["user_id", "lesson_id"], name: "index_progresses_on_user_id_and_lesson_id", unique: true
  add_index "progresses", ["user_id"], name: "index_progresses_on_user_id"

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "order"
  end

  create_table "tutorials", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.text     "content"
    t.integer  "track_id"
    t.string   "permalink"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "name"
    t.string   "location"
    t.string   "remember_token"
    t.integer  "points",          default: 0
    t.string   "permalink"
    t.boolean  "admin",           default: false
    t.boolean  "course_creator",  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
