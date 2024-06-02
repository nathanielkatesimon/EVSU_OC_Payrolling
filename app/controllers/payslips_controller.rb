class PayslipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @payslips = pagy(current_user.payslips.order(created_at: :desc), items: 10)
  end

  def show
    @payslip = Payslip.find(params[:id])
    set_policy!
  end

  private
    def set_policy!
      authorize @payslip, policy_class: PayslipsControllerPolicy
    end
end
