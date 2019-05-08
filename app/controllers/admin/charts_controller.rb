class Admin::ChartsController < Admin::BaseController

  def index
    type = params[:type] || "month"
    @users = User.group_by_type type
    @posts = Post.group_by_type type
    @places = Place.group_by_type type
  end
end
