class CosEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  monetize :sss_cents, :pagibig_calamity_cents, :pagibig_contribution_cents

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

  def summed_up_no_of_worked_days     ## prev_rendered_days
    @summed_up_no_of_worked_days ||= (prev_rendered_hours || 0) + (total_no_of_worked_days || 0)
  end

  def deductions_hash
    total_deductions if @deductions_hash.nil?

    @deductions_hash
  end

  def gross_without_adjustments
    rate * summed_up_no_of_worked_days
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

    keys = CosEntry.monetized_attributes.keys

    keys.each do |key|
      @total_deductions = @total_deductions + self.send(key)
    end

    @total_deductions
  end

  def net
    @net ||= gross - total_deductions
  end
  
end
