module SessionsHelper
  def log_in user
    cookies.permanent.signed[:user_id] = user.id
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif cookies.signed[:user_id] && cookies[:remember_token].present?
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user? user
    current_user == user
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  private

  def check_login
    return if logged_in?
    flash[:danger] = "You Must Log In First!!"
    redirect_to signin_url
  end
end
