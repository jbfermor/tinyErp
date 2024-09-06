class ProductsReturnLineUpdateService

  def initialize(line, param)
    @line = line
    @param = param.to_i
    @price = @line.product.sell_price
  end

  def call
    @line.update(quantity: @param, total_return: @param * @price)
  end

end