FactoryBot.define do
  factory :sell_line do
    user { nil }
    sell { nil }
    product { nil }
    product_quantity { 1 }
    total_sell_line { "9.99" }
  end
end
