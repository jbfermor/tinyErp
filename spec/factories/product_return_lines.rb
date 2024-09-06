FactoryBot.define do
  factory :product_return_line do
    quantity { 1 }
    total_return { "9.99" }
    product_return { nil }
    product { nil }
    sell { nil }
    sell_line { nil }
    user { nil }
    supplier { nil }
    customer { nil }
  end
end
