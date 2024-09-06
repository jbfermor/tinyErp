class BuyDestroyService

  def initialize(buy, user)
    @buy = buy
    @user = user
  end

  def call
    buy.buy_lines.each do |line|
      product = @user.products.find_by(product_id: line.product_id).stock
      product.update(stock: product.stock)
    end
    buy.destroy
  end
end