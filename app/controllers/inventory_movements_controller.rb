class InventoryMovementsController < ApplicationController
  before_action :set_product, only: [:create, :new, :consulta]

  def index
    @suppliers = current_user.suppliers
    @products = @suppliers.find(params[:supplier_id]).products if params[:supplier_id].present?
    @products ||= current_user.products
  end

  def consulta
    # Similar to `index` but maybe with additional logic if needed
    @inventory_movements = @product.inventory_movements.order(created_at: :desc)
    @user = current_user
  end

  def new
    @inventory_movement = @product.inventory_movements.build
  end

  def create
    @inventory_movement = @product.inventory_movements.build(inventory_movement_params)
    @inventory_movement.movement_subtype = 'Manual'
    @inventory_movement.stock_final = calculate_stock(@inventory_movement)
    @inventory_movement.user_id = current_user.id

    if @inventory_movement.save
      @product.save
      redirect_to consulta_product_inventory_movements_path(@product), notice: 'Movimiento creado correctamente.'
    else
      render :new
    end
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end

  def set_inventory_movement
    @inventory_movement = @product.inventory_movements.find(params[:id])
  end

  def inventory_movement_params
    params.require(:inventory_movement).permit(:movement_type, :quantity, :reason)
  end

  def calculate_stock(movement)
    if movement.movement_type == "Entrada"
      @product.stock += movement.quantity
    else
      @product.stock -= movement.quantity
    end
  end
end

