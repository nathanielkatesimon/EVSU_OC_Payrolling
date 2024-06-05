class AddMoreAttributesToCosEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :cos_entries, :prev_rendered_hours, :decimal, precision: 10, scale: 2, default: 0
    add_column :cos_entries, :sss_cents, :integer, default: 0
    add_column :cos_entries, :pagibig_calamity_cents, :integer, default: 0
    add_column :cos_entries, :pagibig_contribution_cents, :integer, default: 0
  end
end
