class NotificationsController < ApplicationController
  def index
    if logged_in?
      @notifications = Notification.admin_check_send_from_type.check_send_to(current_user.id).check_send_from(current_user.id).newest.paginate page: params[:page], per_page: 10
    end
    Notification.admin_check_send_from_type.check_send_to(current_user.id).check_send_from(current_user.id).update opened_at: Time.current
  end
  def destroy
    load_notification
    @notification.destroy
    flash[:success] = "Success!"
    redirect_to notifications_path
  end
  private
  def load_notification
    @notification = Notification.find_by id: params[:id]
  end
end
