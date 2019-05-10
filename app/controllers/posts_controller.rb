class PostsController < ApplicationController
  before_action :check_login, except: :index
  before_action :load_post, except: [:index, :new]
  before_action :correct_post, only: [:edit, :update, :destroy]

  def index; end

  def show
    @notification = Notification.find_by id: params[:notification_id]
    @notification.update opened_at: Time.current if params[:notification_id]
    @avg_rate = @post.rates.average(:star)&.round(2) || 0
    @rate_user = @post.rates.pluck(:user_id)
  end

  def new
    @post = Post.new
    places_max_posts
    @place_options = Place.pluck(:name, :id)
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = "Post is success create "
      redirect_to root_path
    else
      places_max_posts
      @place_options = Place.pluck(:name, :id)
      render :new
    end
  end

  def edit
    @posts= Post.newest.paginate page: params[:page], per_page: 5
    places_max_posts
    @place_options = Place.pluck(:name, :id)
  end

  def update
    @post.update post_params
    flash[:success] = "Post is success update "
    redirect_to root_path
  end

  def destroy
    @post.destroy
    flash[:success] = "Post is success delete "
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit :title, :content, :place_id, :status, :picture
  end

  def load_post
   @post = Post.find_by id: params[:id]
   return true if @post.status == 'archived'
   flash[:danger] = "Post da bi block. Khong the truy cap!"
   redirect_to root_path
  end

  def correct_post
    return if current_user == @post.user
    flash[:warning] = "Ban khong co quyen chinh sua hoac xoa bai viet nay! "
    redirect_to root_path
  end
end
