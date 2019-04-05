class HomesController < ApplicationController
  before_action :new_notifications, only: [:index, :about]
  def index
    if logged_in?
      @posts = Post.newest.paginate page: params[:page], per_page: 5
      places_max_posts
      @place_options = Place.pluck :name, :id
    end
  end

  def about; end

end
