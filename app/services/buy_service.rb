class BuyService
  def self.create_buy(buy)
    buy.state = "Creado"
    buy.total_buy = 0
    buy.save
  end

  def self.update_buy(buy, params)
    buy.update(params)
  end

  def self.destroy_buy(buy)
    buy.destroy
  end

  def self.confirm_buy(buy)
    buy.update(status: :pedido) if buy.creado?
  end

  def self.update_total(buy)
    buy.update(total_buy: buy.buy_lines.sum(:total_buy_line))
  end
end
