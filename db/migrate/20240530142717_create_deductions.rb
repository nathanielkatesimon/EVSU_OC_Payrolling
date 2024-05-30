class CreateDeductions < ActiveRecord::Migration[7.1]
  def change
    create_table :deductions do |t|
      t.references :deductable, polymorphic: true, null: false
      t.integer :amount_cents
      t.string :name

      t.timestamps
    end
  end
end
