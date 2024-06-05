class RegularEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  monetize :witholding_tax_cents, :hdmf_ps_cents, :hdmf_mp2_cents, 
           :phi_ps_cents, :gsis_consol_cents, :plreg_cents, 
           :gsis_help_cents, :gsis_policy_cents, :gsis_gfal_cents, 
           :gsis_emergency_loan_cents, :gsis_mpl_cents, :hdmf_mpl_cents, 
           :cfi_cents, :disallowances_cents, :evsu_mpc_cents,
           :salary_lwop_cents, :other_comp_cents

  enum status: { 
    pending: 0, 
    forwarded_to_accounting: 1, 
    ready_for_ada: 2
  }

  def available_users
    used_ids = payroll.regular_entries.pluck(:user_id)
    User.where.not(id: used_ids)
  end

  def gsis_ps
    @gsis_ps ||= user.basic_pay * 0.09
  end

  def daily_rate
    @daily_rate ||= basic_pay / 24
  end

  def leave_without_pay
    @leave_without_pay ||= absences * daily_rate
  end

  def basic_pay
    @basic_pay ||= user.basic_pay
  end

  def deductions_hash
    total_deductions if @deductions_hash.nil?

    @deductions_hash
  end

  def gross
    @gross ||= basic_pay + salary_lwop + other_comp
  end

  def net
    @net ||= gross - total_deductions
  end

  def first_quincena
    @first_quincena ||= gross / 2
  end

  def second_quincena
    @second_quincena ||= gross - @first_quincena
  end

  def total_deductions
    return @total_deductions unless @total_deductions.nil?

    @total_deductions = Money.new(0)
    
    keys = RegularEntry.monetized_attributes.keys
    keys.delete("salary_lwop")
    keys.delete("other_comp")

    keys.each do |key|
      @total_deductions = @total_deductions + self.send(key)
    end
    
    @total_deductions = @total_deductions + gsis_ps

    @total_deductions
  end
end
