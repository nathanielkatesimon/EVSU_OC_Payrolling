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
      if @regular_entry.update(regular_entry_params)
        format.json { render json: { 
          "success": true, 
          "net": @regular_entry.net.format, 
          "gross": @regular_entry.gross.format, 
          "gsis_ps": @regular_entry.gsis_ps.format, 
          "first_quincena": @regular_entry.first_quincena.format, 
          "second_quincena": @regular_entry.second_quincena.format,
          "total_deductions": @regular_entry.total_deductions.format
          } 
        }
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

    def regular_entry_params
      params.require(:regular_entry).permit(
        :witholding_tax, :hdmf_ps, :hdmf_mp2, :phi_ps, :gsis_consol, :plreg, :gsis_help, :gsis_policy, :gsis_gfal, :gsis_emergency_loan, :gsis_mpl, :hdmf_mpl, :cfi, :disallowances, :evsu_mpc, :salary_lwop, :other_comp
      )
    end
end