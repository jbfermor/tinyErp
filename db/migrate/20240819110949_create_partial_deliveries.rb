class CreatePartialDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :partial_deliveries do |t|
      t.integer :qty_delivered
      t.references :reception_line, null: false, foreign_key: true
      t.references :reception, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
