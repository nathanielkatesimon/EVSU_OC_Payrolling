class CosEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  def available_users
    used_ids = payroll.cos_entries.pluck(:user_id)
    User.where.not(id: used_ids)
  end

  def rate
    @rate ||= user.daily_rate
  end

  def deductions
    @deductions ||= user.deductions
  end

  def deductions_hash
    total_deductions if @deductions_hash.nil?

    @deductions_hash
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
