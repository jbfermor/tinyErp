FactoryBot.define do
  factory :partial_delivery do
    qty_delivered { "MyString" }
    reception_line { nil }
    reception { nil }
    product { nil }
    supplier { nil }
    user_references { "MyString" }
  end
end
