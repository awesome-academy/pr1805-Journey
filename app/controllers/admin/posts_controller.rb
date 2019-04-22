class Admin::PostsController < Admin::BaseController
  before_action :load_post, only: [:show, :destroy]

  def index
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
