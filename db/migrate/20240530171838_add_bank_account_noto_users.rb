class AddBankAccountNotoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :bank_acct_no, :string
  end
end
