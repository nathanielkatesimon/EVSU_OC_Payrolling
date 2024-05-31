class PartTimeEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_part_time_entry, only: %i[ edit update destroy ]

  def new
    @payroll = Payroll.find(params[:payroll_id])
    @part_time_entry = PartTimeEntry.new(payroll: @payroll)
    @part_time_entry.deductions.build
  end

  def create
    @part_time_entry = PartTimeEntry.new(part_time_entry_params)
    respond_to do |format|
      if @part_time_entry.save
        format.html { redirect_to @part_time_entry.payroll, notice: 'Part time entry was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def update
    respond_to do |format|
      if @part_time_entry.update(part_time_entry_params)
        format.html { redirect_to @part_time_entry.payroll, notice: 'Part time entry was successfully updated.' }
      else
        format.html { render :edit, status: :see_other }
      end
    end
  end

  def edit
    if @part_time_entry.deductions.blank?
      @part_time_entry.deductions.build
    end
  end

  def destroy
    @part_time_entry.destroy
    respond_to do |format|
      format.html { redirect_to @part_time_entry.payroll, notice: 'Part time entry was successfully destroyed.' }
    end
  end

  private
    def set_part_time_entry
      @part_time_entry = PartTimeEntry.find(params[:id])
    end

    def part_time_entry_params
      params.require(:part_time_entry).permit(
        :user_id, :rate, :total_rendered_hours, :payroll_id,
        deductions_attributes: [:id, :name, :amount, :_destroy]
      )
    end
end