class Admin::PostsController < Admin::BaseController
  before_action :load_post, only: [:show, :destroy]

  def index
    @posts_titles = Post.search_title(params[:search_title]).newest.paginate page: params[:page], per_page: 10 if params[:search_title]
    @posts_places = Post.search_place(params[:search_place]).newest.paginate page: params[:page], per_page: 10 if params[:search_place]
    @posts_contents = Post.search_content(params[:search_content]).newest.paginate page: params[:page], per_page: 10 if params[:search_content]
    @posts = Post.paginate page: params[:page], per_page: 10
  end

  def show
    @notification = Notification.find_by id: params[:notification_id]
    @notification.update opened_at: Time.zone.now if params[:notification_id]
  end

  def destroy
    if @post.status == "archived"
      @post.update status: :active
      flash[:success] = "Success!"
      redirect_to admin_posts_path
    else
      @post.update status: :archived
      flash[:success] = "Success!"
      redirect_to admin_posts_path
    end
  end

  private

  def load_post
   @post = Post.find_by id: params[:id]
  end
end
