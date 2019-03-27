class HomesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.order_post.paginate page: params[:page], per_page: 5
      places_max_posts
      @place_options = Place.pluck :name, :id
      @post = current_user.posts.build
    end
  end

  def about; end

end
