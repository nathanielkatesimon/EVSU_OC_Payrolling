class PartTimeEntriesControllerPolicy < ApplicationPolicy
  def approve?
    allowed_user && editable_record
  end

  def reject?
    allowed_user && editable_record
  end

  def calculate?
    allowed_user && editable_record
  end

  private
    def allowed_user
      user.human_resources? || user.accounting?
    end

    def editable_record
      record.payroll.pending? || record.payroll.forwarded_to_accounting?
    end
end