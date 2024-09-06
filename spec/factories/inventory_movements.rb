FactoryBot.define do
  factory :inventory_movement do
    movement_type { 1 }
    movement_subtype { 1 }
    quantity { 1 }
    stock_final { 1 }
    reason { "MyString" }
    product { nil }
    reception_line { nil }
    sell_line { nil }
  end
end
