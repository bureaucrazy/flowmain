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

ActiveRecord::Schema.define(version: 20151119004003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifications", force: :cascade do |t|
    t.integer  "status"
    t.string   "error"
    t.string   "ts_data"
    t.integer  "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["sensor_id"], name: "index_notifications_on_sensor_id", using: :btree

  create_table "scadas", force: :cascade do |t|
    t.integer  "value"
    t.string   "ts_data"
    t.integer  "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "scadas", ["sensor_id"], name: "index_scadas_on_sensor_id", using: :btree

  create_table "sensors", force: :cascade do |t|
    t.string   "name"
    t.integer  "sensor_type"
    t.string   "description"
    t.integer  "warning_threshold"
    t.integer  "danger_threshold"
    t.integer  "site_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "sensors", ["site_id"], name: "index_sensors_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.float    "lon"
    t.float    "lat"
    t.string   "description"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "notifications", "sensors"
  add_foreign_key "scadas", "sensors"
  add_foreign_key "sensors", "sites"
end
