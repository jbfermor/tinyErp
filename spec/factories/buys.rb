FactoryBot.define do
  factory :buy do
    user { nil }
    supplier { nil }
    total_buy { "9.99" }
    state { 1 }
  end
end
