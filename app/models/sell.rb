class Sell < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  has_many :sell_lines, dependent: :destroy
  has_many :products_returns, dependent: :destroy
  has_many :products_return_lines, dependent: :destroy

  validates :total_sell, presence: true
  validates :total_sell, numericality: { greater_than_or_equal_to: 0 }

  enum state: { "Pendiente": 0, "Vendido": 1, "Devuelto":3 }

end
