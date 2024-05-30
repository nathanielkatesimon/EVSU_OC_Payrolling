module PayrollHelper
  def payroll_badge(payroll)
    if payroll.pending?
      '<div class="badge bg-primary text-white">Pending</div>'.html_safe
    elsif payroll.forwarded_to_accounting?
      '<div class="badge bg-info text-white">Forwarded to Accounting</div>'.html_safe
    elsif payroll.ready_for_ada?
      '<div class="badge bg-warning">Ready for ADA</div>'.html_safe
    else
      '<div class="badge bg-success">Completed</div>'.html_safe
    end
  end
end
