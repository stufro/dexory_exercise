# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_12_091906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scan_reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scan_results", force: :cascade do |t|
    t.string "name"
    t.boolean "scanned"
    t.boolean "occupied"
    t.string "detected_barcodes", array: true
    t.bigint "scan_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scan_report_id"], name: "index_scan_results_on_scan_report_id"
  end

end