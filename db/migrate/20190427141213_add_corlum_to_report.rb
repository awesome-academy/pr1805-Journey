class AddCorlumToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :send_to_id, :integer
    add_column :reports, :send_to_type, :string
    add_column :reports, :url, :integer
  end
end
