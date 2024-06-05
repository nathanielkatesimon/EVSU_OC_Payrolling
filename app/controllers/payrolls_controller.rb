class PayrollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payroll, only: %i[ show update destroy ada ]
  before_action :set_policy!

  def ada
    @entries = case @payroll.for
              when "part_time"
                @payroll.part_time_entries
              when "cos"
                @payroll.cos_entries
              when "regular"
                @payroll.regular_entries
              end
  end

  def index
    @pagy, @payrolls = pagy(Payroll.all.order(created_at: :desc), items: 10)
  end

  def new
    @payroll = Payroll.new
  end

  def show; end

  def create
    @payroll = Payroll.new(payroll_params)
    respond_to do |format|
      if @payroll.save
        format.html { redirect_to @payroll, notice: 'Payroll was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def update
    respond_to do |format|
      if update_status_or_entries
        format.html { redirect_to @payroll, notice: 'Payroll was successfully updated.' }
      else
        format.html { render :edit, status: :see_other }
      end
    end
  end

  def destroy
    @payroll.destroy
    respond_to do |format|
      format.html { redirect_to payrolls_path, notice: 'Payroll was successfully destroyed.' }
    end
  end

  private
    def update_status_or_entries
      action = params.dig(:payroll, :action)
      
      if action.nil?
        @payroll.update(payroll_params)
      elsif action == "forward_to_accounting"
        @payroll.forward_selected_entries_to_accounting
      elsif action == "return_to_hr"
        @payroll.return_selected_entries_to_hr
      elsif action == "ready_for_ada"
        @payroll.ready_selected_entries_for_ada
      end
    end

    def set_payroll
      @payroll = Payroll.find(params[:id])
    end

    def payroll_params
      params.require(:payroll).permit(:month, :for, :status).merge(
        batch: determine_batch
      )
    end

    def determine_batch
      return @payroll&.batch if @payroll.present? || @payroll&.batches.present?
      month = params.dig(:payroll, :month)
      ffor = params.dig(:payroll, :for)
      Payroll.where(month: month, for: ffor).count + 1
    end

    def set_policy!
      authorize nil, policy_class: PayrollsControllerPolicy
    end
end
