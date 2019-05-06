class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user
      t.references :post
      t.text :content

      t.timestamps
    end
  end
end
