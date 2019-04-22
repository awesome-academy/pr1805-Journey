class Admin::BaseController < ActionController::Base
  layout "admin/application"
  protect_from_forgery with: :exception
  include Admin::SessionsHelper
  before_action :admin_check_login, :report_notification
  def report_notification
    @reports_count = Notification.where("opened_at IS NULL").where("send_from_type = 'Reported' ").newest
    @reports_limit = Notification.where("send_to_id != #{current_admin.id}").where("send_from_type = 'Reported' ").newest.limit(8)
    @reports = Notification.where("send_from_type = 'Reported' ").newest.paginate page: params[:page], per_page: 10
  end
end
