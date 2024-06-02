class Payslip < ApplicationRecord
  belongs_to :user
  belongs_to :entry, polymorphic: true

  def entry_typee
    @entry_typee ||= case entry_type
      when "RegularEntry"
        "Regular"
      when "CosEntry"
        "COS"
      when "PartTimeEntry"
        "Part-Time"
      end
  end

  def payroll_batch
    @payroll_batch ||= "#{entry.payroll.month} batch #{entry.payroll.batch} payroll"
  end
end
