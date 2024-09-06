class InventoryMovementService

  def self.create(move, user, product, reference, params)
    if move.movement_type == "Entrada"
      move.movement_subtype = "Auto"
      move.quantity = params
      move.stock_final = product.stock
      move.partial_delivery_id = reference.id
      move.reason = 1
    elsif move.movement_type == "Salida"
      move.movement_subtype = "Auto"
      move.quantity = params
      move.stock_final = product.stock
      move.reason = 2
    elsif reference.class.name.demodulize == "SellLine"
      move.movement_type = "Salida"
      move.movement_subtype = "Auto"
      move.quantity = params
      move.stock_final = product.stock
      move.sell_line_id = reference.id
      move.reason = 3
    elsif reference.class.name.demodulize == "ProductsReturnLine"
      move.movement_type = "Entrada"
      move.movement_subtype = "Auto"
      move.quantity = params
      move.stock_final = product.stock
      move.products_return_line_id = reference.id
      move.reason = 4
    elsif move.movement_subtype == "Inicial"
      move.movement_type = "Entrada"
      move.quantity = params
      move.stock_final = params
      move.reason = "Stock Inicial"
    else
      if params[:movement_type] == "Entrada"
        move.stock_final = product.stock + params[:quantity]
      else
        move.stock_final = product.stock - params[:quantity]
      end
    end
    move.product_id = product.id
    move.user_id = user.id
    move.save
  end

  def self.update

  end

  def self.destroy
    
  end
end