class Admin::DashboardsController < Admin::BaseController

  def index
    @users = User.group("DATE_FORMAT(activated_at,'%b-%x')").count
    @posts = Post.group("DATE_FORMAT(updated_at,'%b-%x')").count
    @places = Place.group("DATE_FORMAT(updated_at,'%b-%x')").count
  end
end
