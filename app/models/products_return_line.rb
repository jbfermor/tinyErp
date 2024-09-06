class ProductsReturnLine < ApplicationRecord
  belongs_to :products_return
  belongs_to :product
  belongs_to :sell
  belongs_to :sell_line
  belongs_to :user
  belongs_to :supplier
  belongs_to :customer

  has_many :inventory_movements, dependent: :destroy

  enum state: { "Pendiente": 0, "Devuelto": 1 }

  validates :products_return, :user, :customer, :product, :supplier, :sell, :sell_line, presence: true
  validates :quantity, numericality: { greater_than: 0 }   # Cantidad devuelta, validada para ser positiva

end
