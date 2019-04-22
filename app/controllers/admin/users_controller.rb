class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: [:index]
  def index
    @users = User.activated.paginate page: params[:page], per_page: 6
  end

  def show
    if params[:notification_id]
      @notification = Notification.find_by id: params[:notification_id]
      @notification.update opened_at: Time.zone.now
    end
  end

  def edit; end

  def update
    if @user.blocked_at?
      @user.unblock
      flash[:warning] = "Unblock User have Email: #{@user.email} success"
      redirect_to admin_users_path
    else
      @user.block
      flash[:info] = "Block User have Email: #{@user.email} success"
      redirect_to admin_users_path
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "success!"
    redirect_to admin_users_path
  end


  private

  def load_user
      @user = User.find_by id: params[:id]
      return if @user.present?
      flash[:warning] = "User Invalid"
      redirect_to admin_root_url
    end
end
