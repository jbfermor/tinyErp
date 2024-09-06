module InventoryMovementsHelper
  def check_reason(movement)
    case movement.reason
    when "1"
      link_to "Entrega", movement.partial_delivery
    when "2"
      partial = @user.partial_deliveries.find(movement.partial_delivery_id)
      link_to "Eliminación de línea de entrega", partial.reception
    when "3"
      sell_line = @user.sell_lines.find(movement.sell_line_id)
      link_to "Venta", sell_line.sell
    when "4"
      returned = @user.products_return_lines.find(movement.products_return_line_id)
      link_to "Devolución", returned.products_return
    else
      movement.reason
    end
  end
end
