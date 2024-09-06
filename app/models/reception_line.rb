class ReceptionLine < ApplicationRecord
  belongs_to :reception
  belongs_to :buy
  belongs_to :buy_line
  belongs_to :supplier
  belongs_to :product
  belongs_to :user
  has_many :inventory_movements, dependent: :destroy
  has_many :partial_deliveries, dependent: :destroy

  enum state: { "Pedido": 0, "Entregado": 1, "Parcial": 2, "Dependiente": 3 }

  validates :quantity_to_receive, :quantity_received, numericality: {only_integer: true}

  def product_name
    product.product_name
  end

end
