class ReceptionCreationService
  def initialize(user, supplier_id, buy_id)
    @user = user
    @supplier = Supplier.find(supplier_id)
    @buy = Buy.find(buy_id)
  end

  def call
    reception = @user.receptions.create!(
      supplier: @supplier,
      buy: @buy,
      state: "Pedido",
    )
    create_reception_lines(reception)
    reception
  end

  private

  def create_reception_lines(reception)
    @buy.buy_lines.each do |buy_line|
      reception.reception_lines.create!(
        user_id: @supplier.user_id,
        supplier: @supplier,
        product_id: buy_line.product_id,
        buy: @buy,
        buy_line: buy_line,
        quantity_to_receive: buy_line.product_quantity,
        quantity_received: 0,
        state: "Pedido"
      )
    end
  end
end
