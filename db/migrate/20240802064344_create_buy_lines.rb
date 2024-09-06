class CreateBuyLines < ActiveRecord::Migration[7.0]
  def change
    create_table :buy_lines do |t|
      t.references :user, null: false, foreign_key: true
      t.references :buy, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :product_quantity
      t.decimal :total_buy_line
      t.integer :state

      t.timestamps
    end
  end
end
