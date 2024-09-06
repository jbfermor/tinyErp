class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :nif
      t.string :commercial_name
      t.string :contact_person
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :province
      t.string :phone
      t.string :email

      t.timestamps
    end
    add_index :suppliers, :nif, unique: true
    add_index :suppliers, :commercial_name, unique: true
  end
end
