class PartTimeEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_part_time_entry
  before_action :set_policy!

  def approve
    respond_to do |format|
      if @part_time_entry.update(included: true)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def reject
    respond_to do |format|
      if @part_time_entry.update(included: false)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def calculate
    respond_to do |format|
      if @part_time_entry.update(part_time_entry_params)
        format.json { render json: { "success": true, "net": @part_time_entry.net.format, "gross": @part_time_entry.gross.format, "total_rendered_hours": @part_time_entry.total_rendered_hours, "total_deductions": @part_time_entry.total_deductions.format  } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  private
    def set_part_time_entry
      @part_time_entry = PartTimeEntry.find(params[:id])
    end

    def set_policy!
      authorize @part_time_entry, policy_class: PartTimeEntriesControllerPolicy
    end

    def part_time_entry_params
      params.require(:part_time_entry).permit(:total_rendered_hours, :witholding_tax, :pagibig_ps, :pagibig_mpl, :cfi, :advances)
    end
end