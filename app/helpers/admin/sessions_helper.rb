module Admin::SessionsHelper

  def log_in user
    session[:admin_id] = user.id
  end

  def logged_in?
    current_admin.present?
  end

  def current_admin
    if session[:admin_id]
      @current_admin = User.find_by id: session[:admin_id]
    end
  end

  def current_admin? user
    current_admin == user
  end

  def log_out
    session.delete :admin_id
    @current_admin = nil
  end

  private

  def admin_check_login
    return if logged_in?
    flash[:danger] = "You Must Log In First!!"
    redirect_to admin_login_url
  end

  def admin_check_log_out
    return if !logged_in?
    flash[:warning] = "You should Log Out do this"
    redirect_to admin_root_url
  end

end
