class CreatePayslips < ActiveRecord::Migration[7.1]
  def change
    create_table :payslips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :entry, polymorphic: true, null: false

      t.timestamps
    end
  end
end
