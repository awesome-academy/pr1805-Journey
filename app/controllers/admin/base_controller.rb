class Admin::BaseController < ActionController::Base
  layout "admin/application"
  protect_from_forgery with: :exception
  include Admin::SessionsHelper
  include Admin::NotificationsHelper
  before_action :admin_check_login, :report_notification, :new_notifications
  def report_notification
    @reports_count = Notification.check_opened_at.check_send_from_type.newest
    @reports_limits = Notification.check_send_from_type.newest.limit(8)
    @reports = Notification.check_send_from_type.newest.paginate page: params[:page], per_page: 10
  end
  def new_notifications
    @new_notifications_count = Notification.admin_check_send_from_type.check_opened_at.newest
    @notifications_limits = Notification.admin_check_send_from_type.admin_check_send_to_id(current_admin).newest.limit(8)
  end

  def notifications
    @notifications = Notification.admin_check_send_from_type.newest.paginate page: params[:page], per_page: 10
  end
end
