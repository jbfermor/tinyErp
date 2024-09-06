class SellLine < ApplicationRecord
  belongs_to :user
  belongs_to :sell
  belongs_to :product
  belongs_to :user

  has_many :inventory_movements, dependent: :destroy
  has_many :products_return_lines, dependent: :destroy

  validates :product_quantity, presence: true, numericality: true
  validates :total_sell_line, presence: true

  def returned?
    self.products_return_lines.sum(:quantity) == self.product_quantity
  end

end
