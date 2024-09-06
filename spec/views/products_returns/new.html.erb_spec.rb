require 'rails_helper'

RSpec.describe "products_returns/new", type: :view do
  before(:each) do
    assign(:products_return, ProductsReturn.new(
      quantity: 1,
      user: nil,
      product_id: nil,
      sell: nil,
      sell_line: nil
    ))
  end

  it "renders new products_return form" do
    render

    assert_select "form[action=?][method=?]", products_returns_path, "post" do

      assert_select "input[name=?]", "products_return[quantity]"

      assert_select "input[name=?]", "products_return[user_id]"

      assert_select "input[name=?]", "products_return[product_id_id]"

      assert_select "input[name=?]", "products_return[sell_id]"

      assert_select "input[name=?]", "products_return[sell_line_id]"
    end
  end
end
