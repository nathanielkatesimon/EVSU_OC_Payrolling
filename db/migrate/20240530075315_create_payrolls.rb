class CreatePayrolls < ActiveRecord::Migration[7.1]
  def change
    create_table :payrolls do |t|
      t.integer :month
      t.integer :batch
      t.integer :for
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
