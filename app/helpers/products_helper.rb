module ProductsHelper

  def get_customer_name(sell)
    customer = @user.customers.find_by(sell.customer_id)
    "#{customer.name} #{customer.surname1} #{customer.surname2}"
  end

  def get_customer(sell)
    @user.customers.find_by(sell.customer_id)
  end

end
