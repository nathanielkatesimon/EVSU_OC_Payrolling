class AddMoreAttributesToRegularEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :regular_entries, :witholding_tax_cents, :integer, default: 0
    add_column :regular_entries, :hdmf_ps_cents, :integer, default: 0
    add_column :regular_entries, :hdmf_mp2_cents, :integer, default: 0
    add_column :regular_entries, :phi_ps_cents, :integer, default: 0
    add_column :regular_entries, :gsis_consol_cents, :integer, default: 0
    add_column :regular_entries, :plreg_cents, :integer, default: 0
    add_column :regular_entries, :gsis_help_cents, :integer, default: 0
    add_column :regular_entries, :gsis_policy_cents, :integer, default: 0
    add_column :regular_entries, :gsis_gfal_cents, :integer, default: 0
    add_column :regular_entries, :gsis_emergency_loan_cents, :integer, default: 0
    add_column :regular_entries, :gsis_mpl_cents, :integer, default: 0
    add_column :regular_entries, :hdmf_mpl_cents, :integer, default: 0
    add_column :regular_entries, :cfi_cents, :integer, default: 0
    add_column :regular_entries, :disallowances_cents, :integer, default: 0
    add_column :regular_entries, :evsu_mpc_cents, :integer, default: 0
    add_column :regular_entries, :salary_lwop_cents, :integer, default: 0
    add_column :regular_entries, :other_comp_cents, :integer, default: 0
  end
end
