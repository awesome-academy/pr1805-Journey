class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :star
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
