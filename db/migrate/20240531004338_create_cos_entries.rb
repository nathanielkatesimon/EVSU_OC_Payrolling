class CreateCosEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :cos_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rate_cents
      t.decimal :total_no_of_worked_days, precision: 10, scale: 2
      t.decimal :total_late_or_undertime, precision: 10, scale: 2
      t.decimal :total_overtime_hours, precision: 10, scale: 2
      t.references :payroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
