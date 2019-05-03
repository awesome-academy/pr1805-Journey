class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: [:index]
  def index
    @search_users = User.search_name_email(params[:search_name], params[:search_email]).
      newest.paginate page: params[:page], per_page: 6 if params[:search_name] ||
      params[:search_email]
    @users = User.activated.paginate page: params[:page], per_page: 5
  end

  def show
    if params[:notification_id]
      @notification = Notification.find_by id: params[:notification_id]
      @notification.update opened_at: Time.zone.now
    end
  end

  def edit; end

  def update
    if params[:function] == "block"
      if @user.blocked_at?
        @user.unblock
        flash[:success] = "Unblock User have Email: #{@user.email} success"
        redirect_to admin_users_path
      else
        @user.block
        flash[:warning] = "Block User have Email: #{@user.email} success"
        redirect_to admin_users_path
      end
    end
    if params[:function] == "assign"
      if @user.is_admin?
        @user.update_attribute :is_admin, false
        respond_to do |format|
          format.html{ redirect_to @user}
          format.js
        end
      else
        @user.update_attribute :is_admin, true
        respond_to do |format|
          format.html{ redirect_to @user}
          format.js
        end
      end
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
