class CreateSells < ActiveRecord::Migration[7.0]
  def change
    create_table :sells do |t|
      t.references :user, null: false, foreign_key: true
      t.references :customer, null: true, foreign_key: true
      t.decimal :total_sell
      t.integer :state

      t.timestamps
    end
  end
end
