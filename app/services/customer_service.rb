class CustomerService
  def self.create_buy(customer)
    customer.save
  end

  def self.update_buy(customer, params)
    customer.update(params)
  end

  def self.destroy_buy(customer)
    customer.destroy
  end
end

