class ProductService

  def self.update_product(product, params)
    product.update(params)
  end

  def self.destroy_product(product)
    product.destroy
  end

  private

  def create_inventory_movement(product, user)
    inventory_line = InventoryMovement.new(movement_subtype: "Inicial")
    InventoryMovementService.create(inventory_line, user, product, nil, nil)
  end

end
