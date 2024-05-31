class CosEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  has_many :deductions, as: :deductable

  accepts_nested_attributes_for :deductions, reject_if: ->(attributes){ attributes['amount'].blank? || attributes['name'].blank? }, allow_destroy: true

  monetize :rate_cents

  def available_users
    used_ids = payroll.cos_entries.pluck(:user_id)
    User.where.not(id: used_ids)
  end

  def gross_without_adjustments
    rate * total_no_of_worked_days
  end

  def hourly_rate
    @hourly_rate ||= rate / 8.0
  end

  def late_or_undertime_deduction
    @total_late_or_undertime_deduction ||= total_late_or_undertime.minutes.in_hours * hourly_rate
  end

  def overtime_comp
    @overtime_comp ||= total_overtime_hours.hours.in_hours * hourly_rate
  end
  
  def gross
    @gross ||= gross_without_adjustments - late_or_undertime_deduction + overtime_comp
  end

  def total_deductions
    return @total_deductions unless @total_deductions.nil?
    
    @total_deductions = Money.new(0)

    deductions.each { |deduction| @total_deductions = @total_deductions + deduction.amount }

    @total_deductions
  end

  def net
    @net ||= gross - total_deductions
  end
  
end
