class PasswordResetsController < ApplicationController
  before_action :load_user, :user_valid, :check_expiration,
   only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructionsail sent with password reset instructions"
      redirect_to root_url
    else
      flash[:warning] = "Email Invalid!"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      @user.update_attribute :reset_digest, nil
      flash[:success] = "Password Updated!"
      log_in @user
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
  end

  def user_valid
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])
    flash[:success] = "Success !"
    redirect_to root_url
  end

  def check_expiration
    if @user.check_expiration?
      flash[:danger] = "Time Out!"
      redirect_to new_password_reset_path
    end
  end
end
