class BuyLineService
  def self.create_buy_line(buy_line, product, buy)
    buy_line.state ||= "Creado"
    buy_line.product_id = product.id
    buy_line.total_buy_line = buy_line.product_quantity * product.buy_price
    buy_line.buy_id = buy.id
    buy_line.user_id = buy.user_id
    buy_line.save
    BuyService.update_total(buy)
  end

  def self.update_buy_line(buy_line, params, product, buy)   
    buy_line.total_buy_line = params[:product_quantity].to_i * product.buy_price
    buy_line.update(params)
    BuyService.update_total(buy)
  end

  def self.destroy_buy_line(buy_line, buy)
    buy_line.destroy
    BuyService.update_total(buy)
  end
end
