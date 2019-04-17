class Admin::PostsController < Admin::BaseController
  before_action :load_post, only: [:show, :destroy]

  def index
    @posts = Post.all
  end

  def show;  end

  def destroy
    @post.destroy
    flash[:success] = "Post is success delete "
    redirect_to admin_posts_path
  end

  private

  def load_post
   @post = Post.find_by id: params[:id]
  end
end
