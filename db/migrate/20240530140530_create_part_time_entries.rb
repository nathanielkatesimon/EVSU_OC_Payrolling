class CreatePartTimeEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :part_time_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rate_cents
      t.integer :total_rendered_hours
      t.references :payroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
