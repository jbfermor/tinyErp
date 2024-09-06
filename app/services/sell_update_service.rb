class SellUpdateService

  def initialize(sell, user)
    @sell = sell
    @user = user
    @sell_lines = @sell.sell_lines
  end

  def call
    if @sell.update(total_sell: @sell_lines.sum(:total_sell_line),
      state: "Vendido")
      @sell_lines.each do |line|
        product = @user.products.find(line.product_id)
        product.update(stock: product.stock - line.product_quantity)
        create_inventory_movement(product, line)
      end
    end
  end

  private

  def create_inventory_movement(product, line)
    inventory_line = InventoryMovement.new()
    InventoryMovementService.create(inventory_line, @user, product, line, line.product_quantity)
  end  

end