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

ActiveRecord::Schema.define(version: 20150322155610) do

  create_table "authorships", force: true do |t|
    t.integer  "user_id"
    t.integer  "zine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "authorships", ["user_id", "zine_id"], name: "index_authorships_on_user_id_and_zine_id", unique: true
  add_index "authorships", ["user_id"], name: "index_authorships_on_user_id"
  add_index "authorships", ["zine_id"], name: "index_authorships_on_zine_id"

  create_table "paragraphs", force: true do |t|
    t.string   "header"
    t.text     "content"
    t.string   "border_color", default: "000000"
    t.integer  "font_size",    default: 16
    t.integer  "position"
    t.integer  "zine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paragraphs", ["zine_id", "updated_at"], name: "index_paragraphs_on_zine_id_and_updated_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "zines", force: true do |t|
    t.string   "title"
    t.boolean  "published",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zines", ["title", "created_at", "updated_at"], name: "index_zines_on_title_and_created_at_and_updated_at"

end
