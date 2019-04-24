class PlacesController < ApplicationController

  def index
    @places = Place.paginate page: params[:page], per_page: 5
  end
  def show
    @place = Place.find_by id: params[:id]
    places_max_posts
    @posts = @place.posts.newest.paginate page: params[:page], per_page: 5
  end

  private
  def place_params
    params.require(:place).permit :name
  end
end
