module ProductsReturnsHelper

  def line_by_sell_line_id(sell_line)
    @products_return_lines.any? ? @products_return_lines.where(sell_line_id: sell_line.id).sum(:quantity) : 0
  end

  def qty_of_returned_line_by_sell_id(sell_line)
    @previous_returned.any? ? @previous_returned.sum(:quantity) : 0
  end

  def sell_line_qty_minus_returned(sell_line)
    sell_line.product_quantity - line_by_sell_line_id(sell_line) - qty_of_returned_line_by_sell_id(sell_line)
  end
end
