class RegularEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  def available_users
    used_ids = payroll.regular_entries.pluck(:user_id)
    User.where.not(id: used_ids)
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

  def deductions
    @deductions ||= user.deductions
  end

  def gross
    @gross ||= basic_pay - leave_without_pay
  end

  def net
    @net ||= gross - total_deductions
  end

  def total_deductions
    return @total_deductions unless @total_deductions.nil?

    @total_deductions = Money.new(0)
    @deductions_hash = {}

    deductions.each do |deduction|
      @total_deductions = @total_deductions + deduction.amount
      @deductions_hash[deduction.name] = deduction.amount.format
    end

    @total_deductions
  end
end
