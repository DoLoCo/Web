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

ActiveRecord::Schema.define(version: 20141027011418) do

  create_table "bank_accounts", force: true do |t|
    t.string   "bank_account_name"
    t.string   "gateway_reference_id"
    t.string   "status"
    t.integer  "ownable_id"
    t.string   "ownable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_four",            limit: 50
    t.string   "verification_link"
  end

  create_table "campaigns", force: true do |t|
    t.integer  "organization_id"
    t.integer  "bank_account_id"
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.integer  "target_amount"
    t.date     "target_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",       default: ""
  end

  add_index "campaigns", ["bank_account_id"], name: "index_campaigns_on_bank_account_id", using: :btree
  add_index "campaigns", ["organization_id"], name: "index_campaigns_on_organization_id", using: :btree

  create_table "donations", force: true do |t|
    t.integer  "user_id"
    t.integer  "bank_account_id"
    t.integer  "campaign_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "actual_amount"
  end

  add_index "donations", ["bank_account_id"], name: "index_donations_on_bank_account_id", using: :btree
  add_index "donations", ["campaign_id"], name: "index_donations_on_campaign_id", using: :btree
  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "organization_admins", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_admins", ["organization_id"], name: "index_organization_admins_on_organization_id", using: :btree
  add_index "organization_admins", ["user_id"], name: "index_organization_admins_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "phone_number"
    t.text     "description"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.decimal  "lat",           precision: 10, scale: 6
    t.decimal  "lng",           precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",                              default: ""
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "score",           default: 0
    t.string   "image_url",       default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
