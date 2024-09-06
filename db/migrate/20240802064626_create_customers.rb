class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :nif
      t.string :name
      t.string :surname1
      t.string :surname2
      t.string :phone
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :province
      t.string :email

      t.timestamps
    end
  end
end
