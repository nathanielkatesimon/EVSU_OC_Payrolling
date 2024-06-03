class AddRatesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :hourly_rate_cents, :integer, default: 0
    add_column :users, :daily_rate_cents, :integer, default: 0
    add_column :users, :basic_pay_cents, :integer, default: 0
    add_column :users, :salary_grade, :integer, default: 0
  end
end
