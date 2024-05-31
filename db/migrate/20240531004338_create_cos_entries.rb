class CreateCosEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :cos_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rate_cents
      t.integer :total_no_of_worked_days
      t.integer :total_late_or_undertime
      t.integer :total_overtime_hours
      t.references :payroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
