class Admin::BaseController < ActionController::Base
  layout "admin/application"
  protect_from_forgery with: :exception
  include Admin::SessionsHelper
  before_action :admin_check_login
end
