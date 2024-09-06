class SuppliersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @suppliers = if params[:q].present?
      current_user.suppliers.where("nif LIKE ? OR commercial_name LIKE ? OR contact_person LIKE ? OR postal_code LIKE ? OR province LIKE ? OR phone LIKE ?", 
      "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      current_user.suppliers
    end
  end

  def show
    @products = @supplier.products
    @buys = @supplier.buys.order(created_at: :desc)
    @user = current_user
  end

  def new
    @supplier = current_user.suppliers.build
  end

  def create
    @supplier = current_user.suppliers.build(supplier_params)
    if SupplierService.create_supplier(@supplier)
      redirect_to @supplier, notice: 'El Proveedor se creó con éxito'
    else
      redirect_to suppliers_path, alert: "No pudo crearse el Proveedor"
    end
  end

  def edit
  end

  def update
    if SupplierService.update_supplier(@supplier, supplier_params)
      redirect_to @supplier, notice: 'Los datos se actualizaron correctamente'
    else
      render :edit
    end
  end

  def destroy
    SupplierService.destroy_supplier(@supplier)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@supplier)
      end
      format.html { redirect_to suppliers_path, notice: 'El proveedor se eliminó correctamente' }
    end
  end

  private

  def set_supplier
    @supplier = current_user.suppliers.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:nif, :commercial_name, :contact_person, :address, :city, :postal_code, :province, :phone)
  end
end
