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
      if @part_time_entry.update(total_rendered_hours: params[:total_rendered_hours])
        format.json { render json: { "success": true, "net": @part_time_entry.net.format, "gross": @part_time_entry.gross.format } }
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
end