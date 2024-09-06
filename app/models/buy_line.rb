class BuyLine < ApplicationRecord
  belongs_to :user
  belongs_to :buy
  belongs_to :product
  has_one :reception_line, dependent: :destroy

  validates :product_quantity, presence: true, numericality: true
  validates :total_buy_line, presence: true, numericality: true
  enum state: { "Creado": 0, "Pedido": 1, "Entregado": 2, "Parcial": 3 }

end
