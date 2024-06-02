class CreateRegularEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :regular_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :basic_pay_cents
      t.references :payroll, null: false, foreign_key: true
      t.decimal :absences, precision: 10, scale: 2

      t.timestamps
    end
  end
end
