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

ActiveRecord::Schema.define(version: 20171121112206) do

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.float "transaction_fee"
    t.integer "minimum_confirmation"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "histories", force: :cascade do |t|
    t.string "name"
    t.float "o"
    t.float "h"
    t.float "l"
    t.float "c"
    t.float "bv"
    t.datetime "t"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "v"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.string "base"
    t.string "currency_name"
    t.string "base_name"
    t.float "minimum_trade"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orderbooks", force: :cascade do |t|
    t.string "name"
    t.string "t"
    t.float "q"
    t.float "r"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "uuid"
    t.string "ordertype"
    t.string "exchange"
    t.float "quantity"
    t.float "remaining"
    t.float "price"
    t.float "total"
    t.string "fill"
    t.float "limit"
    t.float "commission"
    t.datetime "opened_at"
    t.datetime "executed_at"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "orderuuid"
    t.float "priceperunit"
    t.boolean "isopen"
    t.boolean "cancelinitiated"
    t.float "condtarget"
    t.boolean "immediate"
    t.integer "bittrexid", limit: 8
    t.boolean "conditional"
    t.string "condition"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "uuid"
    t.string "address"
    t.string "currency"
    t.float "balance"
    t.float "available"
    t.float "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
