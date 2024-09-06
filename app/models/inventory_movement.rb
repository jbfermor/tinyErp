class InventoryMovement < ApplicationRecord
  belongs_to :product
  belongs_to :partial_delivery, optional: true
  belongs_to :sell_line, optional: true
  belongs_to :products_return_line, optional: true
  belongs_to :user

  enum movement_type: { "Entrada": 0, "Salida": 1 }
  enum movement_subtype: { "Auto": 0, "Manual": 1, "Inicial": 2 }

  validates :quantity, presence: true

  def adjust_stock
    if self.sell_line_id
      self.product.update(stock: self.product.stock + self.sell_line.product_quantity)
    elsif self.products_return_line_id
      self.product.update(stock: self.product.stock - self.products_return_line.quantity)
    end
  end

end
