class ProductsReturnLineService

  def initialize(line, sell_line)
    @line = line
    @sell_line = sell_line
  end

  def call_create
    @line.user_id = @sell_line.user_id
    @line.product_id = @sell_line.product_id
    @line.total_return = @sell_line.product.sell_price * @line.quantity
    @line.state = "Pendiente"
    @line.sell_id = @sell_line.sell_id
    @line.sell_line_id = @sell_line.id
    @line.supplier_id = @sell_line.product.supplier_id
    @line.customer_id = @line.products_return.customer_id
    @line.save
  end

  def call_update

  end

  def call_delete
    @line.destroy
  end
end