class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_policy!

  def index; end

  def update
    respond_to do |format|
      if update_current_user
        bypass_sign_in(current_user)
        format.html { redirect_to profile_index_url, notice: 'Profile was successfully updated.' }
      else
        format.html { render :index, status: :see_other }
      end
    end
  end


  private
    def profile_params
      @profile_params ||= params.require(:user).permit(
        :email, :password, :first_name, :last_name, :department, :bank_acct_no, :current_password
      ).compact_blank!
    end

    def update_current_user
      if profile_params[:password].present?
        current_user.update_with_password(profile_params)
      else
        profile_params.delete(:current_password)
        current_user.update(profile_params)
      end
    end

    def set_policy!
      authorize current_user, policy_class: ProfileControllerPolicy
    end
end
