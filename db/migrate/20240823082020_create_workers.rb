class CreateWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :worker_bios do |t|
      t.string :nif
      t.string :name
      t.string :surname1
      t.string :surname2
      t.string :address
      t.string :city
      t.string :postal
      t.string :province
      t.string :phone
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
