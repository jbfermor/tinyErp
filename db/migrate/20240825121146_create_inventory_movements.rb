class CreateInventoryMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_movements do |t|
      t.integer :movement_type
      t.integer :movement_subtype
      t.integer :quantity
      t.integer :stock_final
      t.string :reason
      t.references :product, null: false, foreign_key: true
      t.references :partial_delivery, foreign_key: true
      t.references :sell_line, foreign_key: true
      t.references :products_return_line, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
