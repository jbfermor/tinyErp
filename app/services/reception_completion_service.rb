class ReceptionCompletionService

  def initialize(reception, user)
    @reception = reception
    @user = user
  end

  def call
    @reception.reception_lines.each do |line|
      partial_delivery = @user.partial_deliveries.build()
      if line.state != "Entregado"
        pending_qty = line.quantity_to_receive - line.quantity_received
        service = PartialDeliveryCreationService.new(partial_delivery, line, pending_qty , @user)
        service.call
      end
    end
  end

end


