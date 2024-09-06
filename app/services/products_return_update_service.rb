class ProductsReturnUpdateService
  def initialize(returned, param, type)
    @returned = returned
    @param = params
    @type = type
  end

  def call
    if @type == "customer"
      @returned.update(customer_id: @param)
    elsif @type == "sell"
      @returned.update(sell_id: @param)
    end
  end
end