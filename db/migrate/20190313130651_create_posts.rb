class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.float :avg_star
      t.references :user
      t.references :place

      t.timestamps
    end
  end
end
