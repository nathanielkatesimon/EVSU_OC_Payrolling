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

ActiveRecord::Schema[7.1].define(version: 2024_06_04_010049) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cos_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total_no_of_worked_days", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_late_or_undertime", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_overtime_hours", precision: 10, scale: 2, default: "0.0"
    t.bigint "payroll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "included", default: false
    t.index ["payroll_id"], name: "index_cos_entries_on_payroll_id"
    t.index ["user_id"], name: "index_cos_entries_on_user_id"
  end

  create_table "deductions", force: :cascade do |t|
    t.string "deductable_type", null: false
    t.bigint "deductable_id", null: false
    t.integer "amount_cents"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deductable_type", "deductable_id"], name: "index_deductions_on_deductable"
  end

  create_table "part_time_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total_rendered_hours", precision: 10, scale: 2, default: "0.0"
    t.bigint "payroll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "included", default: false
    t.index ["payroll_id"], name: "index_part_time_entries_on_payroll_id"
    t.index ["user_id"], name: "index_part_time_entries_on_user_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.integer "month"
    t.integer "batch"
    t.integer "for"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payslips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "entry_type", null: false
    t.bigint "entry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_type", "entry_id"], name: "index_payslips_on_entry"
    t.index ["user_id"], name: "index_payslips_on_user_id"
  end

  create_table "regular_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "payroll_id", null: false
    t.decimal "absences", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "included", default: false
    t.index ["payroll_id"], name: "index_regular_entries_on_payroll_id"
    t.index ["user_id"], name: "index_regular_entries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.integer "department"
    t.integer "employment_type"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank_acct_no"
    t.integer "hourly_rate_cents", default: 0
    t.integer "daily_rate_cents", default: 0
    t.integer "basic_pay_cents", default: 0
    t.integer "salary_grade", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cos_entries", "payrolls"
  add_foreign_key "cos_entries", "users"
  add_foreign_key "part_time_entries", "payrolls"
  add_foreign_key "part_time_entries", "users"
  add_foreign_key "payslips", "users"
  add_foreign_key "regular_entries", "payrolls"
  add_foreign_key "regular_entries", "users"
end
