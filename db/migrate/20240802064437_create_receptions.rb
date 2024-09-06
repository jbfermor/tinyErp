class CreateReceptions < ActiveRecord::Migration[7.0]
  def change
    create_table :receptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :buy, null: false, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
