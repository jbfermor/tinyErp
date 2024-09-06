FactoryBot.define do
  factory :product do
    user { nil }
    supplier { nil }
    product_name { "MyString" }
    product_description { "MyText" }
    stock { 1 }
    min_stock { 1 }
    state { 1 }
  end
end
