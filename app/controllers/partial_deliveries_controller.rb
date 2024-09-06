class PartialDeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_partial_delivery, only: [:destroy]

  def create
    
    if params[:partial_delivery].present?
      @reception_line = current_user.reception_lines.find(params[:partial_delivery][:reception_line_id])
      qty_params = params[:partial_delivery][:qty_delivered].to_i
    else
      @reception_line = current_user.reception_lines.find(params[:reception_line_id])
      qty_params = @reception_line.quantity_to_receive - @reception_line.quantity_received
    end
    @reception = current_user.receptions.find(@reception_line.reception_id)
    @partial_delivery = current_user.partial_deliveries.build()
    service = PartialDeliveryCreationService.new(@partial_delivery, @reception_line, qty_params, current_user )
    if service.call
      @reception_lines = @reception.reception_lines
      @partial_deliveries = @reception.partial_deliveries 
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @reception, notice: 'Se ha creado el movimiento' }
      end
    else
      @reception_lines = @reception.reception_lines
      @partial_deliveries = @reception.partial_deliveries 
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @reception, alert: 'No se pudo crear el movimiento.' }
      end
    end
  end

  def destroy
    service = PartialDeliveryDeleteService.new(@partial_delivery, current_user)
    @reception = current_user.receptions.find(@partial_delivery.reception_id)
    if service.call
      @reception_lines = @reception.reception_lines
      @partial_deliveries = @reception.partial_deliveries 
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @reception, notice: 'Se ha eliminado el movimiento' }
      end
    else
      @reception_lines = @reception.reception_lines
      @partial_deliveries = @reception.partial_deliveries 
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @reception, alert: 'No se pudo eliminar el movimiento.' }
      end
    end
  end

  private 

  def set_partial_delivery
    @partial_delivery = current_user.partial_deliveries.find(params[:id])
  end

end
