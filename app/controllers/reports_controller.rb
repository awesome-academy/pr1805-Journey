class ReportsController < ApplicationController
  before_action :load_report, only: [:new, :create]

  def new
    @report = Report.new
  end

  def create
    if logged_in?
      @report = @current_user.reports.build report_params
      if @report.save
        Notification.create(send_from_id: @report.user_id, send_to_id: @report.post.user_id,
          send_from_type: "Reported", send_to_type: "Post", url: @report.post_id )
        flash[:success] = "Success!"
        redirect_to root_path
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
    params.require(:report).permit :content, :post_id
  end

  def load_report
    @post = Post.find_by id: params[:post_id]
  end
end
