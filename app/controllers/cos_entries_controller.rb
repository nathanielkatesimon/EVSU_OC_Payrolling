class CosEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cos_entry
  before_action :set_policy!

  def approve
    respond_to do |format|
      if @cos_entry.update(included: true)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def reject
    respond_to do |format|
      if @cos_entry.update(included: false)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def calculate
    respond_to do |format|
      if @cos_entry.update(cos_params)
        format.json { render json: { 
          "success": true, 
          "net": @cos_entry.net.format, 
          "gross": @cos_entry.gross.format, 
          "overtime_comp": @cos_entry.overtime_comp.format, 
          "late_or_undertime_deduction": @cos_entry.late_or_undertime_deduction.format,
          "total_deductions": @cos_entry.total_deductions.format,
          "total_no_of_days": @cos_entry.summed_up_no_of_worked_days
          } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  private
    def cos_params
      params.require(:cos_entry).permit(
        :total_no_of_worked_days, :total_late_or_undertime, :total_overtime_hours, :prev_rendered_hours,
        :sss, :pagibig_calamity, :pagibig_contribution
        ).compact_blank!
    end

    def set_cos_entry
      @cos_entry = CosEntry.find(params[:id])
    end

    def set_policy!
      authorize @cos_entry, policy_class: CosEntriesControllerPolicy
    end
end