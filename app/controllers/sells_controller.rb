class SellsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sell, only: [:search_products, :show, :update, :destroy]

  def index
    @sells = current_user.sells.order(created_at: :desc)
    @filtered_sells = filter_sells(@sells, params[:query])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @sell_lines = @sell.sell_lines
    @filtered_products = filter_products(@products, params[:query])
    @customers = current_user.customers
    if @sell.state == "Pendiente"
      @products = if params[:q].present?
        current_user.products.where(state: "Activo").where("product_name LIKE ? ", "%#{params[:q]}%")
      else 
        current_user.products.where state: "Activo"
      end
    end
   
  end

  def create
    @sell = current_user.sells.new(total_sell: 0)
    if SellService.create_sell(@sell)
      redirect_to @sell, notice: 'Sell was successfully created.'
    else
      redirect_to sells_path, alert: 'Sell was not created'
    end
  end

  def update
    service = SellUpdateService.new(@sell, current_user)
    if service.call
      redirect_to @sell, notice: 'Sell was successfully updated.'
    else
      redirect_to sells_path, alert: 'Sell was not updated'
    end
  end

  def destroy
    @sell.destroy
    redirect_to sells_url, notice: 'Sell was successfully destroyed.'
  end

  def search_products
    render turbo_stream: turbo_stream.replace("product_table", "sell_lines/products_table", local: @products)
  end

  private

  def set_sell
    @sell = params[:sell_id].present? ? current_user.sells.find(params[:sell_id]) : current_user.sells.find(params[:id]) 
  end

  def filter_sells(sells, query)
    return sells unless query.present?

    sells.joins(:customer).where('customers.name LIKE ? OR customers.surname1 LIKE ? OR customers.nif LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def filter_products(products, query)
    return products unless query.present?

    products.where('product_name LIKE ? ', "%#{query}%")
  end

end
