class CosEntriesControllerPolicy < ApplicationPolicy
  def approve?
    user.human_resources? && record.payroll.pending?
  end

  def reject?
    user.human_resources? && record.payroll.pending?
  end

  def calculate?
    user.human_resources? && record.payroll.pending?
  end
end