class ChangeDefaultValues < ActiveRecord::Migration[7.1]
  def change
    change_column :part_time_entries, :total_rendered_hours, :decimal, precision: 10, scale: 2, default: 0
    change_column :regular_entries, :absences, :decimal, precision: 10, scale: 2, default: 0
    change_column :cos_entries, :total_no_of_worked_days, :decimal, precision: 10, scale: 2, default: 0
    change_column :cos_entries, :total_late_or_undertime, :decimal, precision: 10, scale: 2, default: 0
    change_column :cos_entries, :total_overtime_hours, :decimal, precision: 10, scale: 2, default: 0
  end
end
