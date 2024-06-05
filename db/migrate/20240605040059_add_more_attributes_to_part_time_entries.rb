class AddMoreAttributesToPartTimeEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :part_time_entries, :witholding_tax_cents, :integer, default: 0
    add_column :part_time_entries, :pagibig_ps_cents, :integer, default: 0
    add_column :part_time_entries, :pagibig_mpl_cents, :integer, default: 0
    add_column :part_time_entries, :advances_cents, :integer, default: 0
    add_column :part_time_entries, :cfi_cents, :integer, default: 0
  end
end
