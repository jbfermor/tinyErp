class SellLinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sell
  before_action :set_sell_line, only: [:destroy]

  def new
    @products = current_user.products.where(state: "Activo").limit(5) # Filtra productos activos y limita a 5
  end

  def create
    @sell_line = @sell.sell_lines.new(sell_line_params)
    # SellLineService responderá con 0 si se realiza el Save y
    # responderá con 1 si falta stock para lo pedido
    service = SellLineCreationService.new(@sell_line, sell_line_params, @sell, current_user) 
    
    case service.call
    when 0
      respond_to do |format|
        format.html { redirect_to @sell, notice: 'Producto añadido con éxito.' }
        format.turbo_stream
      end
    when 1
      @products = current_user.products.where(status: "Activo").limit(5)
      redirect_to @sell, alert: "No hay suficiente stock para este producto"
    else
      @products = current_user.products.where(status: "Activo").limit(5)
      redirect_to @sell, alert: "No se ha podido añadir el producto"
    end
  end

  def destroy
    SellLineService.destroy(@sell_line)
    redirect_to @sell, notice: "Producto eliminado del carrito satisfactoriamente"
  end

  def search
    query = params[:query]
    @products = Product.where(state: "Activo")
                       .where("product_name ILIKE ?", "%#{query}%")
                       .limit(5)
    render turbo_stream: turbo_stream.replace("product_table", partial: "sell_lines/products_table", locals: { products: @products })
  end

  private

  def set_sell
    @sell = params[:sell_id].present? ? current_user.sells.find(params[:sell_id]) : current_user.sells.find(params[:id]) 
  end

  def set_sell_line
    @sell_line = @sell.sell_lines.find(params[:id])
  end

  def sell_line_params
    params.require(:sell_line).permit(:product_id, :product_quantity, :total_sell_line)
  end
end
