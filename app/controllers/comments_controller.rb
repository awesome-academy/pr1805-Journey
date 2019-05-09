class CommentsController < ApplicationController
  before_action :load_post
  before_action :logged_in?, only: [:index, :show]
  before_action :load_comment, except: [:new, :create]
  before_action :get_user, only: [:create, :update]

  def index
    @comments = params[:post_id] ? (Post.find_by(id: params[:id]).include :posts) : (Comment.paginate page: params[:page], per_page: 5)
  end

  def new
    @comment = @post.comments.build comment_params
  end

  def show; end

  def create
    @comment = @post.comments.build comment_params
    if current_user? @user
      if @comment.save
        Notification.create(send_from_id: current_user.id, send_to_id: @post.user.id,
          send_from_type: "Commented", send_to_type: "Post",
          report_id: "", post_id: @post.id, comment_id: @comment.id)
        flash[:success] = "Comment Success"
        redirect_to @post
      else
        flash[:warning] = "Comment Fail"
        redirect_to @post
      end
    else
      flash[:warning] = "Comment Fail"
      redirect_to @post
    end
  end

  def edit; end

  def update
    if @comment.update comment_params
      flash[:success] = "Updated Your Comment"
      redirect_to @post
    else
      render :edit
    end
  end


  def destroy
    if @comment.present?
      @comment.destroy
      flash[:success] = "Deleted Comment Success!!"
    else
      flash[:fail] = "Delete Comment Error!!"
    end
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id
  end

  def load_post
   @post = Post.find_by id: params[:post_id]
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def get_user
    @user = User.find_by id: params[:comment][:user_id]
  end
end
