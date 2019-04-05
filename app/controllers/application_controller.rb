class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def places_max_posts
    query = Post.select("place_id, COUNT(id) as post_count").group("place_id").order("post_count desc")
    @places = Place.joins("right JOIN (#{query.to_sql}) sub on places.id = sub.place_id").limit(5)
  end
   def new_notifications
    if logged_in?
      @new_notifications = current_user.notifications.check_send_to(current_user.id).check_send_from(current_user.id).newest
    end
  end
end
