class BuyLinesController < ApplicationController
  before_action :set_buy
  before_action :set_product, only: [:create]

  def create
    @buy_line = @buy.buy_lines.new(buy_line_params)

    if BuyLineService.create_buy_line(@buy_line, @product, @buy)
      @products = @buy.supplier.products if @buy.supplier.present?
      @buy_lines = @buy.buy_lines.reload # Asegúrate de que @buy_lines esté actualizado
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @buy, notice: 'BuyLine was successfully created.' }
      end
    else
      @products = @buy.supplier.products if @buy.supplier.present?
      @buy_lines = @buy.buy_lines.reload # Asegúrate de que @buy_lines esté actualizado
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @buy, notice: 'No se pudo crear.' }
      end
    end
  end

  def update
    @buy_line = BuyLine.find(params[:id])
    @product = current_user.products.find(@buy_line.product_id)

    if BuyLineService.update_buy_line(@buy_line, buy_line_params, @product, @buy)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @buy, notice: 'BuyLine was successfully updated.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('buy_lines', partial: 'buys/buy_lines', locals: { buy: @buy }) }
        format.html { render 'buys/show' }
      end
    end
  end

  def destroy
    @buy_line = BuyLine.find(params[:id])

    BuyLineService.destroy_buy_line(@buy_line, @buy)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @buy, notice: 'BuyLine was successfully destroyed.' }
    end
  end

  private

  def set_buy
    @buy = current_user.buys.find(params[:buy_id])
  end

  def set_product
    @product = current_user.products.find(params[:buy_line][:product_id])
  end

  def buy_line_params
    params.require(:buy_line).permit(:product_id, :product_quantity)
  end
end
