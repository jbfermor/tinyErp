class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buy, only: [:change_state, :show, :destroy, :confirm]
  before_action :set_supplier, only: [:create]

  def index
    if params[:supplier_id]
      @buys = current_user.buys.where(supplier_id: params[:supplier_id])
    else
      @buys = current_user.buys.order(created_at: :desc)
    end
    @filtered_buys = filter_buys(@buys, params[:query])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
    @suppliers = current_user.suppliers
  end

  def show
    @user = current_user
    @buy_lines = @buy.buy_lines
    @products = @buy.supplier.present? ? @buy.supplier.products : []
  end

  def create
    @buy = current_user.buys.build
    @buy.supplier_id ||= params[:supplier_id]
    if BuyService.create_buy(@buy)
      redirect_to @buy, notice: 'La compra fue creada con éxito'
    else
      if params[:supplier_id]
        redirect_to current_user.suppliers.find(params[:supplier_id]), alert: "No se pudo crear la compra"
      else
        render :index, status: :unprocessable_entity
      end
    end
  end

  def destroy
    BuyService.destroy_buy(@buy)
    redirect_to buys_url, notice: 'Buy was successfully destroyed.'
  end

  def update_supplier
    @buy.update(supplier_id: params[:supplier_id])
    redirect_to @buy
  end

  def place_order
    @buy = Buy.find(params[:id])

    if @buy.buy_lines.empty?
      redirect_to @buy, alert: 'No se puede realizar el pedido porque no hay productos añadidos a la compra.'
      return
    end

    # Actualiza el estado del Buy y sus BuyLines a 'Pedido'
    ActiveRecord::Base.transaction do
      @buy.update!(state: 'Pedido')
      @buy.buy_lines.update_all(state: 'Pedido')

      # Crear la recepción asociada
      ReceptionCreationService.new(current_user, @buy.supplier_id, @buy.id).call
    end

    redirect_to buys_path, notice: 'El pedido ha sido realizado exitosamente y la recepción ha sido creada.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @buy, alert: "Hubo un problema al realizar el pedido: #{e.message}"
  end

  def change_state
    @buy.update(state: "Creado")
    current_user.receptions.find_by(buy_id: @buy).destroy
    redirect_to @buy, alert: "El pedido ha vuelto al estado Creado y se puede modificar"
  end

  private

  def set_buy
    @buy = current_user.buys.find(params[:id])
  end

  def set_supplier
    @supplier = params[:supplier_id] ? current_user.suppliers.find(params[:supplier_id]) : nil
  end

  def buy_params
    params.require(:buy).permit(:supplier_id)
  end

  def filter_buys(buys, query)
    return buys if query.blank?
    buys.joins(:supplier).where("buys.id LIKE ? OR suppliers.commercial_name LIKE ? OR buys.state LIKE ?", 
                                 "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
