class Admin::NotificationsController < Admin::BaseController
  before_action :load_notification, :notifications
  def index;  end

  def destroy
    if @notification.send_from_type == "Reported"
      @notification.destroy
      flash[:success] = "Success!"
      redirect_to admin_reports_path
    else
      @notification.destroy
      flash[:success] = "Success!"
      redirect_to admin_notifications_path
    end
  end

  private
  def load_notification
    @notification = Notification.find_by id: params[:id]
  end
end
