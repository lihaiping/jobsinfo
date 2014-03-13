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

ActiveRecord::Schema.define(version: 20140313202748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "guides", force: true do |t|
    t.integer  "type_id",     null: false
    t.integer  "industry_id", null: false
    t.string   "title",       null: false
    t.string   "abstract"
    t.text     "content",     null: false
    t.string   "image",       null: false
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information", force: true do |t|
    t.integer  "type_id",      null: false
    t.integer  "job_id",       null: false
    t.string   "company",      null: false
    t.string   "position",     null: false
    t.string   "experience",   null: false
    t.string   "salary",       null: false
    t.text     "requirement",  null: false
    t.string   "contact",      null: false
    t.string   "image",        null: false
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "release_time", null: false
  end

  create_table "jobs", force: true do |t|
    t.string   "name",        null: false
    t.integer  "industry_id", null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer "user_id"
    t.integer "job_id"
  end

  add_index "subscriptions", ["job_id"], name: "index_subscriptions_on_job_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "types", force: true do |t|
    t.string   "keyword",     null: false
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "types", ["keyword"], name: "index_types_on_keyword", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "openid",     null: false
    t.string   "nickname",   null: false
    t.string   "area"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["openid"], name: "index_users_on_openid", unique: true, using: :btree

end
