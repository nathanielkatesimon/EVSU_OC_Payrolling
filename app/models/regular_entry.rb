class RegularEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  has_many :deductions, as: :deductable

  accepts_nested_attributes_for :deductions, reject_if: ->(attributes){ attributes['amount'].blank? || attributes['name'].blank? }, allow_destroy: true

  monetize :basic_pay_cents

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

  def gross
    @gross ||= basic_pay - leave_without_pay
  end

  def net
    @net ||= gross - total_deductions
  end

  def total_deductions
    return @total_deductions unless @total_deductions.nil?
    
    @total_deductions = Money.new(0)

    deductions.each { |deduction| @total_deductions = @total_deductions + deduction.amount }

    @total_deductions
  end
end
