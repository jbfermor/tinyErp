class CreateProductsReturns < ActiveRecord::Migration[7.0]
  def change
    create_table :products_returns do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :sell, null: true, foreign_key: true
      t.integer :state, default: 0
      t.text :reason

      t.timestamps
    end
  end
end
