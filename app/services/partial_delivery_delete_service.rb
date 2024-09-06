class PartialDeliveryDeleteService

  def initialize(partial_delivery, user)
    @partial_delivery = partial_delivery
    @user = user
    @reception_line = @user.reception_lines.find(partial_delivery.reception_line_id)
    @product = user.products.find(partial_delivery.product_id)
  end

  def call
    if @partial_delivery.destroy
      @reception_line.update(quantity_received: @reception_line.quantity_received - @partial_delivery.qty_delivered)
      @product.update(stock: @product.stock - @partial_delivery.qty_delivered)
      update_reception_line_state
      update_states
      create_inventory_movement
    end
  end

  private

  def update_reception_line_state
    buy_line = @user.buy_lines.find(@reception_line.buy_line_id)
    if @reception_line.quantity_received >= @reception_line.quantity_to_receive
      @reception_line.update(state: "Entregado")
      buy_line.update(state: "Entregado")
    elsif @reception_line.quantity_received.between?(1, @reception_line.quantity_to_receive)
      @reception_line.update(state: "Parcial") 
      buy_line.update(state: "Parcial") 
    else
      @reception_line.update(state: "Pedido") 
      buy_line.update(state: "Pedido")
    end
  end

  def update_states
    reception = @user.receptions.find(@partial_delivery.reception_id)
    buy = @user.buys.find(@reception_line.buy_id)
    if reception.reception_lines.all? { |line| line.state == "Entregado" }
      reception.update(state: "Entregado")
      buy.update(state: "Entregado")
    elsif reception.reception_lines.all? { |line| line.state == "Pedido" }
      reception.update(state: "Pedido")
      buy.update(state: "Pedido")
    else
      reception.update(state: "Parcial")
      buy.update(state: "Parcial")
    end
  end

  def create_inventory_movement
    inventory_line = InventoryMovement.new(movement_type: "Salida")
    InventoryMovementService.create(inventory_line, @user, @product, @reception_line, @partial_delivery.qty_delivered)
  end

end