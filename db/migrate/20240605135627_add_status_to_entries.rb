class AddStatusToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :part_time_entries, :status, :integer, default: 0
    add_column :regular_entries, :status, :integer, default: 0
    add_column :cos_entries, :status, :integer, default: 0
  end
end
