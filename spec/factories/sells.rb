FactoryBot.define do
  factory :sell do
    user { nil }
    customer { nil }
    sell_date { "2024-08-02" }
    total_sell { "9.99" }
  end
end
