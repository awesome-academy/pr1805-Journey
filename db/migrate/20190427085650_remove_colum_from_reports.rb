class RemoveColumFromReports < ActiveRecord::Migration[5.1]
  def change
    remove_column :reports, :post_id, :integer
    remove_column :reports, :user_id, :integer
    remove_column :reports, :opened_at, :datetime
  end
end
