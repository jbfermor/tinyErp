class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.string :product_name
      t.text :product_description
      t.integer :stock
      t.decimal :buy_price, precision: 10, scale: 2 # Ajusta la precisión y escala según lo que necesites
      t.decimal :sell_price, precision: 10, scale: 2 # Ajusta la precisión y escala según lo que necesites
      t.integer :min_stock
      t.integer :state

      t.timestamps
    end
  end
end
