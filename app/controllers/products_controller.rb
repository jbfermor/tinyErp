class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:toggle_state, :show, :edit, :update, :destroy]
  before_action :set_suppliers, only: [:new, :create, :edit]

  def index
    @products = if params[:q].present?
                  Product.includes(:supplier).where("name LIKE ? OR stock LIKE ? OR suppliers.commercial_name LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%").references(:suppliers)
                else
                  Product.includes(:supplier).where(supplier: current_user.suppliers)
                end
  end

  def show
    @buys = current_user.buys
    @sells = current_user.sells
    @user = current_user
    @deliveries = current_user.reception_lines
    @returns = current_user.products_return_lines
  end

  def new
    @product = Product.new
    @product.supplier_id = params[:supplier_id] if params[:supplier_id]
  end

  def create
    @product = current_user.products.build(product_params)
    service = ProductCreationService.new(@product)
    if service.call
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      set_suppliers
      render :new
    end
  end

  def edit
  end

  def update
    if ProductService.update_product(@product, product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      set_suppliers
      render :edit
    end
  end

  def destroy
    ProductService.destroy_product(@product)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@product)
      end
      format.html { redirect_to products_path, notice: 'Product was successfully deleted.' }
    end
  end

  def toggle_state
    @product.state == "Activo" ? @product.update(state: "Inactivo") : @product.update(state: "Activo")
    
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'El estado del producto ha sido actualizado.' }
    end
  end

  private

  def set_product
    @product = current_user.products.find(params[:id])
  end

  def set_suppliers
    @suppliers = current_user.suppliers
  end

  def product_params
    params.require(:product).permit(:product_name, :buy_price, :sell_price, :stock, :min_stock, :state, :supplier_id, :product_description)
  end
end
