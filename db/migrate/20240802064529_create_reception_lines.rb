class CreateReceptionLines < ActiveRecord::Migration[7.0]
  def change
    create_table :reception_lines do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :buy, null: false, foreign_key: true
      t.references :buy_line, null: false, foreign_key: true
      t.references :reception, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity_to_receive
      t.integer :quantity_received
      t.integer :state

      t.timestamps
    end
  end
end
