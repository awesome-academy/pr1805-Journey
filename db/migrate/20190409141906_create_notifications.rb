class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :send_from_type
      t.string :send_to_type
      t.integer :send_to_id
      t.integer :send_from_id
      t.integer :url
      t.datetime :opened_at

      t.timestamps
    end
  end
end
