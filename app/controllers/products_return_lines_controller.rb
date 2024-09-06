class ProductsReturnLinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_products_return_line, only: [ :update, :destroy ]

  def create
    sell_line = current_user.sell_lines.find(line_params[:sell_line_id])
    @line = current_user.products_return_lines.build(line_params)
    @line.products_return_id = params[:products_return_id]
    service = ProductsReturnLineService.new(@line, sell_line)
    if service.call_create
      redirect_to @line.products_return, notice: "Línea añadida"
    else
      redirect_to @line.products_return, alert: "Línea no añadida"
    end
  end

  def update
    service = ProductsReturnLineUpdateService.new(@line, line_params[:quantity])
    if service.call
      redirect_to @line.products_return, notice: "Cantidad modificada correctamente"
    else
      redirect_to @line.products_return, alert: "No se ha podido modificar la cantidad"
    end
  end

  def destroy
    service = ProductsReturnLineDestroyService.new(@line)
    if service.call_destroy
    redirect_to @line.products_return, notice: "Línea eliminada correctamente"
    else
      redirect_to @line.products_return, alert: "No se ha podido eliminar la línea"
    end
  end

  private

  def set_products_return_line
    @line = current_user.products_return_lines.find(params[:id])
  end

  def line_params
    params.require(:products_return_line).permit(:quantity, :sell_line_id)
  end

end
