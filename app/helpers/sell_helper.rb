module SellHelper

  def check_sell_lines(sell_lines, product)
    sell_line = @sell_lines.find_by(product_id: product.id)
    if sell_line 
      if sell_line.product_quantity == product.stock
        false
      else
        true
      end
    else
      true
    end
  end
end
