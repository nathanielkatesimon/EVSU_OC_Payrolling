class RegularEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_regular_entry, only: %i[ edit update destroy ]

  def new
    @payroll = Payroll.find(params[:payroll_id])
    @regular_entry = RegularEntry.new(payroll: @payroll)
    @regular_entry.deductions.build
  end

  def create
    @regular_entry = RegularEntry.new(part_time_entry_params)
    respond_to do |format|
      if @regular_entry.save
        format.html { redirect_to @regular_entry.payroll, notice: 'Regular entry was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def update
    respond_to do |format|
      if @regular_entry.update(part_time_entry_params)
        format.html { redirect_to @regular_entry.payroll, notice: 'Regular entry was successfully updated.' }
      else
        format.html { render :edit, status: :see_other }
      end
    end
  end

  def edit
    if @regular_entry.deductions.blank?
      @regular_entry.deductions.build
    end
  end

  def destroy
    @regular_entry.destroy
    respond_to do |format|
      format.html { redirect_to @regular_entry.payroll, notice: 'Regular entry was successfully destroyed.' }
    end
  end

  private
    def set_regular_entry
      @regular_entry = RegularEntry.find(params[:id])
    end

    def part_time_entry_params
      params.require(:regular_entry).permit(
        :user_id, :basic_pay, :absences, :payroll_id,
        deductions_attributes: [:id, :name, :amount, :_destroy]
      )
    end
end