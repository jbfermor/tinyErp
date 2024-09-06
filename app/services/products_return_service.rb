class ProductsReturnService

  def self.create_return(products_return, user)
    products_return.customer_id = user.customers.first.id
    products_return.state = "Pendiente"
    products_return.save
  end

end