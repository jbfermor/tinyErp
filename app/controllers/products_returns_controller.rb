class ProductsReturnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_products_return, only: %i[ confirm_return show update destroy ]
  before_action :set_products_return_lines, only: [:show, :confirm_return]

  # GET /products_returns or /products_returns.json
  def index
    @products_returns = current_user.products_returns
  end

  # GET /products_returns/1 or /products_returns/1.json
  def show
    @sells = current_user.sells.where(state: "Vendido").order(created_at: :desc)
    @customers = current_user.customers
    @previous_returned = current_user.products_return_lines.where(state: "Devuelto").where(sell_id: @products_return.sell_id)
    @total_returns = @products_return_lines.sum(:total_return)
  end

  # POST /products_returns or /products_returns.json
  def create
    @products_return = ProductsReturn.new(user_id: current_user.id)
    if params[:sell_id]
      @products_return.sell_id = params[:sell_id]
      @products_return.customer_id = @products_return.sell.customer_id
    end
    if ProductsReturnService.create_return(@products_return, current_user)
      redirect_to @products_return, notice: 'Devolución creada con éxito.'
    else
      render :index, alert: "No se ha podido crear la devolución"
    end
  end

  # PATCH/PUT /products_returns/1 or /products_returns/1.json
  def update
    respond_to do |format|
      if @products_return.update(products_return_params)
        format.html { redirect_to products_return_url(@products_return), notice: "Products return was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products_returns/1 or /products_returns/1.json
  def destroy
    @products_return.destroy

    respond_to do |format|
      format.html { redirect_to products_returns_url, notice: "Products return was successfully destroyed." }
    end
  end

  def confirm_return
    if params[:stockable] == "true"
      @products_return_lines.each do |line|
        product = current_user.products.find(line.product_id)
        product.update(stock: line.product.stock + line.quantity)
        InventoryMovementService.create(InventoryMovement.new, current_user, product, line, line.quantity)
      end
    end
    @products_return_lines.each {|line| line.update(state:"Devuelto") }
    @products_return.update(state: "Devuelto")
    @products_return.update(reason: params[:reason])
    @products_return.sell.update(state: "Devuelto") if @products_return.sell.sell_lines.all? { |line| line.returned? }

    redirect_to @products_return
  end


  private

    # Only allow a list of trusted parameters through.
    def products_return_params
      params.require(:products_return).permit(:user_id, :customer_id, :sell_id, :state, :reason)
    end

    def set_products_return
      @products_return = current_user.products_returns.find(params[:id])
    end

    def set_products_return_lines
      @products_return_lines = @products_return.products_return_lines.where(state: "Pendiente")
    end

end
