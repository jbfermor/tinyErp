require 'rails_helper'

RSpec.describe "products_returns/index", type: :view do
  before(:each) do
    assign(:products_returns, [
      ProductsReturn.create!(
        quantity: 2,
        user: nil,
        product_id: nil,
        sell: nil,
        sell_line: nil
      ),
      ProductsReturn.create!(
        quantity: 2,
        user: nil,
        product_id: nil,
        sell: nil,
        sell_line: nil
      )
    ])
  end

  it "renders a list of products_returns" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
