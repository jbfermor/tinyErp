class CreateProductsReturnLines < ActiveRecord::Migration[7.0]
  def change
    create_table :products_return_lines do |t|
      t.integer :quantity
      t.decimal :total_return
      t.integer :state
      t.references :products_return, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :sell, null: false, foreign_key: true
      t.references :sell_line, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
