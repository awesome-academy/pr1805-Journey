class Admin::SessionsController < Admin::BaseController
  skip_before_action :admin_check_login, :report_notification, :new_notifications
  before_action :admin_check_log_out, only: [:new, :create]

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.is_admin?
        log_in user
        flash[:info] = "Welcome #{user.name}"
        redirect_to admin_root_url
      else
        flash[:warning] = "Oops!! Something Wrongs!!"
        render :new
      end
    end
  end

  def destroy
    log_out
    flash[:info] = "See Yaaa <3"
    redirect_to admin_login_url
  end
end

