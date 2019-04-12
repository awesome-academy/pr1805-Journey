class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.blocked_at?
        flash[:warning] = "Account was BAN at
          #{user.blocked_at.strftime("%T-%d/%m/%Y")}!!
          Contact to Admin via Mail: duynn.mta@gmai.com"
        redirect_to root_url
      else
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_to user
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
      end
    else
      flash[:warning] = "Oops!! Something Wrongs!!"
      render :new
    end
  end

  def destroy
    log_out
    flash[:info] = "See Yaaa <3"
    redirect_to root_url
  end
end
