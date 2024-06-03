class RegularEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_regular_entry
  before_action :set_policy

  def approve
    respond_to do |format|
      if @regular_entry.update(included: true)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def reject
    respond_to do |format|
      if @regular_entry.update(included: false)
        format.json { render json: { "success": true } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  def calculate
    respond_to do |format|
      if @regular_entry.update(absences: params[:absences])
        format.json { render json: { "success": true, "net": @regular_entry.net.format, "gross": @regular_entry.gross.format, "absents": @regular_entry.leave_without_pay.format } }
      else
        format.json { render json: { "success": false } }
      end
    end
  end

  private
    def set_regular_entry
      @regular_entry = RegularEntry.find(params[:id])
    end

    def set_policy
      authorize @regular_entry, policy_class: RegularEntriesControllerPolicy
    end
end