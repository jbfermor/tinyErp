require 'rails_helper'

RSpec.describe "products_returns/edit", type: :view do
  let(:products_return) {
    ProductsReturn.create!(
      quantity: 1,
      user: nil,
      product_id: nil,
      sell: nil,
      sell_line: nil
    )
  }

  before(:each) do
    assign(:products_return, products_return)
  end

  it "renders the edit products_return form" do
    render

    assert_select "form[action=?][method=?]", products_return_path(products_return), "post" do

      assert_select "input[name=?]", "products_return[quantity]"

      assert_select "input[name=?]", "products_return[user_id]"

      assert_select "input[name=?]", "products_return[product_id_id]"

      assert_select "input[name=?]", "products_return[sell_id]"

      assert_select "input[name=?]", "products_return[sell_line_id]"
    end
  end
end
