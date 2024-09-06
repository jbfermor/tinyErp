class SellLineCreationService

  def initialize(sell_line, params, sell, user)
    @sell_line = sell_line
    @params = params[:product_quantity].to_i
    @sell = sell
    @user = user
    @product = user.products.find(params[:product_id])
  end

  def call
    @sell_line.sell_id = @sell.id
    @sell_line.user_id =  @user.id
    @sell_line.product_id = @product.id
    @sell_line.product_quantity = @params
    @sell_line.total_sell_line = @product.sell_price * @params
    if @params > @product.stock
      1
    else
      if @sell_line.save
        0
      else
        puts @sell_line.errors.full_messages # Esto imprimirá los errores en la consola
        2
      end
    end
  end 
end