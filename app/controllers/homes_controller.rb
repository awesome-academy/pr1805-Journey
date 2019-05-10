class HomesController < ApplicationController

  def index
    if logged_in?
      @posts = Post.check_status.newest.paginate page: params[:page], per_page: 5
      places_max_posts
      @place_options = Place.check_status.pluck :name, :id
    end
  end

  def about; end

end
