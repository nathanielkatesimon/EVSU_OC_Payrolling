class PartTimeEntry < ApplicationRecord
  belongs_to :user
  belongs_to :payroll

  has_many :deductions, as: :deductable

  accepts_nested_attributes_for :deductions, reject_if: ->(attributes){ attributes['amount'].blank? || attributes['name'].blank? }, allow_destroy: true

  monetize :rate_cents

  def gross
    @gross ||= rate * total_rendered_hours
  end

  def net
    @net ||= calculate_net
  end

  def total_deductions
    return @total_deductions unless @total_deductions.nil?
    
    @total_deductions = Money.new(0)

    deductions.each { |deduction| @total_deductions = @total_deductions + deduction.amount }

    @total_deductions
  end

  private
    def calculate_net
      gross - total_deductions
    end
end
