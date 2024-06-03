class AddIncludedOptionToPartTimeEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :part_time_entries, :included, :boolean, default: :false
  end
end
