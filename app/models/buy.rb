class Buy < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  has_many :buy_lines, dependent: :destroy
  has_many :receptions, dependent: :destroy

  enum state: { "Creado": 0, "Pedido": 1, "Entregado": 2, "Parcial": 3 }

  validates :total_buy, numericality: { greater_than_or_equal_to: 0 }

end
