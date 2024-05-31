class CosEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_part_time_entry, only: %i[ edit update destroy ]

  def new
    @payroll = Payroll.find(params[:payroll_id])
    @cos_entry = CosEntry.new(payroll: @payroll)
    @cos_entry.deductions.build
  end

  def create
    @cos_entry = CosEntry.new(cos_entry_params)
    respond_to do |format|
      if @cos_entry.save
        format.html { redirect_to @cos_entry.payroll, notice: 'COS entry was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def destroy
    @cos_entry.destroy
    respond_to do |format|
      format.html { redirect_to @cos_entry.payroll, notice: 'COS entry was successfully destroyed.' }
    end
  end

  def update
    respond_to do |format|
      if @cos_entry.update(cos_entry_params)
        format.html { redirect_to @cos_entry.payroll, notice: 'COS entry was successfully updated.' }
      else
        format.html { render :edit, status: :see_other }
      end
    end
  end

  def edit
    if @cos_entry.deductions.blank?
      @cos_entry.deductions.build
    end
  end

  private
    def set_part_time_entry
      @cos_entry = CosEntry.find(params[:id])
    end

    def cos_entry_params
      params.require(:cos_entry).permit(
        :user_id, :rate, :total_no_of_worked_days, :payroll_id, :total_late_or_undertime, :total_overtime_hours,
        deductions_attributes: [:id, :name, :amount, :_destroy]
      )
    end
end