class CreateSellLines < ActiveRecord::Migration[7.0]
  def change
    create_table :sell_lines do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sell, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :product_quantity
      t.decimal :total_sell_line

      t.timestamps
    end
  end
end
