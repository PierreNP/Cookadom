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

ActiveRecord::Schema.define(version: 2021_09_07_102735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "stripe_customer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "comment"
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_comments_on_recipient_id"
    t.index ["sender_id"], name: "index_comments_on_sender_id"
  end

  create_table "cooks", force: :cascade do |t|
    t.bigint "user_id"
    t.string "siren"
    t.string "business_name"
    t.string "legal_status"
    t.string "headquarter"
    t.string "vat_number"
    t.string "commercial_register"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cooks_on_user_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.string "ingredients"
    t.bigint "cook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cook_id"], name: "index_dishes_on_cook_id"
  end

  create_table "order_dishes", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "cart_id"
    t.bigint "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_order_dishes_on_cart_id"
    t.index ["dish_id"], name: "index_order_dishes_on_dish_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rate"
    t.bigint "user_id"
    t.bigint "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_ratings_on_dish_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "tag_dishes", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_tag_dishes_on_dish_id"
    t.index ["tag_id"], name: "index_tag_dishes_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "status", default: 0
    t.string "first_name"
    t.string "last_name"
    t.bigint "city_id"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
