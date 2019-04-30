class Admin::ReportsController < Admin::BaseController
  before_action :load_report, only: :show
  def index;  end

  def show;  end

  private
  def load_report
    @report = Report.find_by id: params[:id]
  end
end
