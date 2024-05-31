class PayrollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payroll, only: %i[ show update destroy ada ]

  def ada
    @entries = case @payroll.for
              when "part_time"
                @payroll.part_time_entries
              when "cos"
                @payroll.cos_entries
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
        format.html { redirect_to root_path, notice: 'Payroll was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def update
    respond_to do |format|
      if @payroll.update(payroll_params)
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
end
