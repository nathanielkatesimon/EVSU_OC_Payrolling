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
      if @cos_entry.update(absences: params[:absences])
        format.json { render json: { "success": true, "net": @cos_entry.net.format, "gross": @cos_entry.gross.format, "absents": @cos_entry.leave_without_pay.format } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  private
    def set_cos_entry
      @cos_entry = CosEntry.find(params[:id])
    end

    def set_policy!
      authorize @cos_entry, policy_class: CosEntriesControllerPolicy
    end
end