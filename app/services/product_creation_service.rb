class ProductCreationService
  
  def initialize(product)
    @product = product
  end

  def call
    @product.min_stock ||= 0
    @product.state ||= 'Activo'
    @product.save
    create_inventory_movement if @product.stock > 0
  end

  private

  def create_inventory_movement
    inventory_line = InventoryMovement.new(movement_subtype: "Inicial")
    InventoryMovementService.create(inventory_line, @product.user, @product, "", @product.stock)
  end

end
