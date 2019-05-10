class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include NotificationsHelper
  before_action :new_notifications
  before_action :place_options

  def places_max_posts
    query = Post.select("place_id, COUNT(id) as post_count").group("place_id").order("post_count desc")
    @places = Place.joins("right JOIN (#{query.to_sql}) sub on places.id = sub.place_id").limit(5)
  end
  def new_notifications
    if logged_in?
      @new_notifications_count = Notification.admin_check_send_from_type.check_send_to(current_user.id).check_send_from(current_user.id).check_opened_at.newest
      @notifications_limits = Notification.admin_check_send_from_type.check_send_to(current_user.id).check_send_from(current_user.id).newest.limit(8)
    end
  end

  def place_options
    @place_options = Place.check_status.pluck(:name, :id)
  end
end
