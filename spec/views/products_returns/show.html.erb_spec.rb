require 'rails_helper'

RSpec.describe "products_returns/show", type: :view do
  before(:each) do
    assign(:products_return, ProductsReturn.create!(
      quantity: 2,
      user: nil,
      product_id: nil,
      sell: nil,
      sell_line: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
