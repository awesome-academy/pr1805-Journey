class AddReviewToRates < ActiveRecord::Migration[5.1]
  def change
    add_column :rates, :review, :text
  end
end
