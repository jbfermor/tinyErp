class Reception < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :buy
  has_many :reception_lines, dependent: :destroy
  has_many :partial_deliveries, dependent: :destroy

  enum state: { "Pedido": 0, "Entregado": 1, "Parcial": 2 }

end
