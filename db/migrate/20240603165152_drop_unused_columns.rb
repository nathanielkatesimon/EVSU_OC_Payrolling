class DropUnusedColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :part_time_entries, :rate_cents
    remove_column :cos_entries, :rate_cents
    remove_column :regular_entries, :basic_pay_cents
  end
end
