module PayrollHelper
  def payroll_badge(payroll)
    if payroll.pending?
      '<div class="badge bg-primary text-white">Pending</div>'.html_safe
    else
      '<div class="badge bg-success">Completed</div>'.html_safe
    end
  end

  def entries_to_view_for(user, payroll)
    if payroll.completed?
      :ready_for_ada
    elsif user.human_resources?
      :pending
    elsif user.accounting?
      :forwarded_to_accounting
    elsif user.disbursing?
      :ready_for_ada
    end
  end
end
