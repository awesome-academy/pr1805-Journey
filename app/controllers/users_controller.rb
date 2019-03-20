class UsersController <  ApplicationController
  def index
    @user = User.scope(activated: true)
  end

  def new
    @user= User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
    redirect_to root_url if !@user.activated?
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation
  end
end
