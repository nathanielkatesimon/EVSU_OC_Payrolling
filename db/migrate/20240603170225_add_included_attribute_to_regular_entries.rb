class AddIncludedAttributeToRegularEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :regular_entries, :included, :boolean, default: :false
  end
end
