class PartTimeEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  def rate
    @rate ||= user.hourly_rate
  end

  def available_users
    used_ids = payroll.part_time_entries.where.not(user_id: user_id).pluck(:user_id)
    User.where.not(id: used_ids)
  end

  def gross
    @gross ||= rate * (total_rendered_hours || 0.0)
  end

  def net
    @net ||= calculate_net
  end

  def deductions
    @deductions ||= user.deductions
  end

  def deductions_hash
    total_deductions if @deductions_hash.nil?

    @deductions_hash
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

  private
    def calculate_net
      gross - total_deductions
    end
end
