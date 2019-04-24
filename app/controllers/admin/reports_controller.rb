class Admin::ReportsController < Admin::BaseController
  before_action :load_report, only: [:show, :destroy]
  def index;  end

  def show;  end

  def destroy;  end

  private
  def load_report
    @report = Report.find_by id: params[:id]
  end
end
