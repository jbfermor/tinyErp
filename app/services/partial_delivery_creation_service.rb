class PartialDeliveryCreationService

  def initialize(partial_delivery, reception_line, params, user)
    @partial_delivery = partial_delivery
    @reception_line = reception_line
    @qty_delivered = params
    @user = user
    @product = @user.products.find(@reception_line.product_id)
  end

  def call
    @partial_delivery.qty_delivered = @qty_delivered
    @partial_delivery.reception_line_id = @reception_line.id
    @partial_delivery.reception_id = @reception_line.reception_id
    @partial_delivery.product_id = @product.id
    @partial_delivery.supplier_id = @reception_line.supplier_id
    @partial_delivery.user_id = @user.id
    if @partial_delivery.save
      @reception_line.update(quantity_received: @reception_line.quantity_received + @partial_delivery.qty_delivered)
      @product.update(stock: @product.stock + @qty_delivered)
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
    end
  end

  def update_states
    reception = @user.receptions.find(@partial_delivery.reception_id)
    buy = @user.buys.find(@reception_line.buy_id)
    if reception.reception_lines.all? { |line| line.state == "Entregado" }
      reception.update(state: "Entregado")
      buy.update(state: "Entregado")
    else
      reception.update(state: "Parcial")
      buy.update(state: "Parcial")
    end
  end

  def create_inventory_movement
    inventory_line = InventoryMovement.new(movement_type: "Entrada")
    InventoryMovementService.create(inventory_line, @user, @product, @partial_delivery, @partial_delivery.qty_delivered)
  end

end