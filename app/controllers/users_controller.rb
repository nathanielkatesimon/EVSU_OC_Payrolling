class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_policy

  def index
    @pagy, @users = pagy(User.all.order(created_at: :desc), items: 10)
  end

  def show; end

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new, status: :see_other }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :see_other }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
    end
  end

  private

    def user_params
      params.require(:user)
      .permit(
        :email, :password, :first_name, :last_name, :role, :department, :employment_type, :bank_acct_no
      ).compact_blank!
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_policy
      authorize current_user, policy_class: UsersControllerPolicy
    end
end