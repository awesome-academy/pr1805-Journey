class Admin::DashboardsController < Admin::BaseController
  before_action :admin_check_login
  def index; end
end
