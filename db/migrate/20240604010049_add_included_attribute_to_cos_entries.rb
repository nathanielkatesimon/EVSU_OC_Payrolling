class AddIncludedAttributeToCosEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :cos_entries, :included, :boolean, default: false
  end
end
