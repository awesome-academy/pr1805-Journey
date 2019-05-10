class Admin::PlacesController < Admin::BaseController
  before_action :load_place, only: [:edit, :update, :destroy]
  def index
    @search_places = Place.search_place(params[:search_place]).newest.paginate page: params[:page], per_page: 10 if params[:search_place]
    @place = Place.new
    @places = Place.paginate page: params[:page], per_page: 10
  end

  def edit;  end

  def create
    @place = Place.new place_params
    if @place.save
      flash[:success] = "Success!"
      redirect_to admin_places_path
    else
      flash[:danger] = "Fails!"
      redirect_to admin_places_path
    end
  end

  def update
    if @place.update place_params
      flash[:success] = "Success!"
      redirect_to admin_places_path
    else
      render :edit
    end
  end

  def destroy
    if @place.status == "active"
      @place.update status: :archived
      flash[:success] = "Success!"
      redirect_to admin_places_path
    else
      @place.update status: :active
      flash[:success] = "Success!"
      redirect_to admin_places_path
    end
  end

  private
  def load_place
    @place = Place.find_by id: params[:id]
  end

  def place_params
    params.require(:place).permit :name, :status, :image
  end
end
