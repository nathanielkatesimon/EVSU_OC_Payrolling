class PrevRenderedHoursToPartTimeEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :part_time_entries, :prev_rendered_hours, :decimal, precision: 10, scale: 2, default: 0
  end
end
