class RemoveColumToNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :url, :integer
  end
end
