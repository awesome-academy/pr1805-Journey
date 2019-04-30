class AddReportIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :report_id, :integer
  end
end
