class SellService
  def self.create_sell(sell)
    sell.customer_id = Customer.find(1)
    sell.state = "Pendiente"
    sell.save
  end

  def self.destroy_sell(sell)
    sell.destroy
  end
end