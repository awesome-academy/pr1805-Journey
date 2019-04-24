class Admin::NotificationsController < Admin::BaseController
  before_action :load_notification, :notifications
  def index;  end

  def show;  end

  def destroy;  end

  private
  def load_notification
    @notification = Notification.find_by id: params[:id]
  end
end
