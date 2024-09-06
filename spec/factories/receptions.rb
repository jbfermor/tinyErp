FactoryBot.define do
  factory :reception do
    user { nil }
    supplier { nil }
    buy { nil }
    last_reception_date { "2024-08-02" }
    state { 1 }
  end
end
