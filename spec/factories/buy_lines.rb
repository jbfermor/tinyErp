FactoryBot.define do
  factory :buy_line do
    user { nil }
    buy { nil }
    product { nil }
    buy_date { "2024-08-02" }
    product_quantity { 1 }
    total_buy_line { "9.99" }
    state { 1 }
  end
end
