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

ActiveRecord::Schema.define(version: 20170105143307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "categories", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "comments", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.text     "message"
    t.uuid     "user_id"
    t.uuid     "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "countries", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "brand"
    t.string   "last4"
    t.string   "name"
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "locations", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.uuid     "country_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "stripe_id",                            null: false
    t.string   "name",                                 null: false
    t.integer  "amount",                               null: false
    t.datetime "created"
    t.string   "currency",             default: "USD", null: false
    t.string   "interval"
    t.integer  "interval_count"
    t.boolean  "livemode"
    t.text     "statement_descriptor"
    t.integer  "trial_period_days"
    t.uuid     "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "plans", ["user_id"], name: "index_plans_on_user_id", using: :btree

  create_table "posts", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.uuid     "category_id"
    t.uuid     "user_id"
    t.integer  "updated_by"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "plan_id"
    t.integer  "comments_count", default: 0, null: false
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "subscriptions", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "stripe_id"
    t.boolean  "cancel_at_period_end"
    t.datetime "canceled_at"
    t.datetime "created"
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.datetime "ended_at"
    t.boolean  "livemode"
    t.integer  "quantity"
    t.datetime "start"
    t.string   "status"
    t.datetime "trial_end"
    t.datetime "trial_start"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.uuid     "plan_id"
    t.uuid     "user_id"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v1()", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.uuid     "location_id"
    t.uuid     "customer_id"
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "plans", "users"
  add_foreign_key "subscriptions", "users"
end
