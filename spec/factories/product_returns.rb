FactoryBot.define do
  factory :product_return do
    quantity { 1 }
    user { nil }
    product_id { nil }
    sell { nil }
    sell_line { nil }
  end
end
