class ReportsController < ApplicationController
  before_action :load_post, only: [:new, :create]

  def new
    @report = Report.new
  end

  def create
    if logged_in?
      @report = Report.new report_params
      if @report.save
        Notification.create(send_from_id: current_user.id, send_to_id: @report.send_to_id,
          send_from_type: "Reported", send_to_type: @report.send_to_type,
          report_id: @report.id, post_id: @report.url, comment_id: "")
        flash[:success] = "Success!"
        respond_to do |format|
          format.html{redirect_to root_path}
          format.js
        end
      else
        flash[:warning] = "Fails!"
        render :new
      end
    else
      flash[:warning] = "Not Auth"
      redirect_to sign_in_path
    end
  end

  private

  def report_params
    params.require(:report).permit :content, :send_to_id, :send_to_type, :url
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
  end
end
