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

ActiveRecord::Schema.define(version: 20180410141119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "business_name"
    t.string "address_1"
    t.string "address_2"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "phone"
    t.float "latitude"
    t.float "longitude"
    t.date "date_start"
    t.date "date_end"
    t.integer "status", default: 1
    t.integer "addressable_id"
    t.string "addressable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "code_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "codes", force: :cascade do |t|
    t.bigint "institution_id"
    t.string "content"
    t.integer "code_category_id"
    t.date "date_start"
    t.date "date_end"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_category_id"], name: "index_codes_on_code_category_id"
    t.index ["institution_id"], name: "index_codes_on_institution_id"
  end

  create_table "institution_categories", force: :cascade do |t|
    t.bigint "institution_id"
    t.integer "institution_category_label_id"
    t.date "date_start"
    t.date "date_end"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_category_label_id"], name: "index_institution_categories_on_institution_category_label_id"
    t.index ["institution_id"], name: "index_institution_categories_on_institution_id"
  end

  create_table "institution_category_labels", force: :cascade do |t|
    t.string "short_label"
    t.string "long_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institution_names", force: :cascade do |t|
    t.bigint "institution_id"
    t.integer "status", default: 1
    t.string "text"
    t.string "initials"
    t.date "date_start"
    t.date "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_institution_names_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "link_categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.bigint "institution_id"
    t.string "content"
    t.integer "link_category_id"
    t.date "date_start"
    t.date "date_end"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_links_on_institution_id"
    t.index ["link_category_id"], name: "index_links_on_link_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
