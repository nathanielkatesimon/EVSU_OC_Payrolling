class PartTimeEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  monetize :witholding_tax_cents, :pagibig_ps_cents, :pagibig_mpl_cents, :advances_cents, :cfi_cents

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

    keys = PartTimeEntry.monetized_attributes.keys

    keys.each do |key|
      @total_deductions = @total_deductions + self.send(key)
    end

    @total_deductions
  end

  private
    def calculate_net
      gross - total_deductions
    end
end
