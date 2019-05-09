class UsersController <  ApplicationController
  before_action :authenticate, except: [:new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.activated.paginate page: params[:page], per_page: 5
    @results = User.search_user params[:keyword]
    return if params[:find].blank?
    return if @results.present?
    flash[:warning] = "User Invalid"
    redirect_to users_path
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
    @notification = Notification.find_by id: params[:notification_id]
    @notification.update opened_at: Time.current if params[:notification_id]
    @unfollow = current_user.active_relations.find_by(followed_id: @user.id)
    @posts = @user.posts.newest.paginate page: params[:page], per_page: 5
    redirect_to root_url if !@user.activated?
    places_max_posts
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

  def following
    @users = @user.following.paginate page: params[:page], per_page: 5
    render :show_follow
  end

  def followers
    @users = @user.followers.paginate page: params[:page], per_page: 5
    render :show_follow
  end


  private

  def load_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation , :bio , :phone , :picture
  end

  def authenticate
    return if logged_in?
    flash[:danger] = "You shoud log in first to do this"
    redirect_to root_url
  end

  def correct_user
    return if current_user == @user
    flash[:warning] = "Oops! Not Permissions!"
    redirect_to current_user
  end
end
