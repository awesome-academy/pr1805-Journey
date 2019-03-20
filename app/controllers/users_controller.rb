class UsersController <  ApplicationController
  before_action :correct_user , only: [:show ,:edit, :update]

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
    redirect_to root_url if !@user.activated?
  end

  def edit; end

  def update
    if @user.update user_params
     redirect_to user_path
     flash[:success] = "Updated!!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation , :bio , :phone ,:picture
  end

  def correct_user
    @user = User.find_by params[:id]
    if current_user =! @user
      flash[:warning] = "Oops! Not Permissions!"
      redirect_to user_path(current_user)
    end
  end
end
