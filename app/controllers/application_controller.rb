class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def places_max_posts
    query = Post.select("place_id, COUNT(id) as post_count").group("place_id").order("post_count desc")
    @places = Place.joins("right JOIN (#{query.to_sql}) sub on places.id = sub.place_id").limit(5)
  end
end
