FactoryBot.define do
  factory :reception_line do
    user { nil }
    supplier { nil }
    buy { nil }
    buy_line { nil }
    reception { nil }
    reception_line_date { "2024-08-02" }
    quantity_to_receive { 1 }
    quantity_received { 1 }
    state { 1 }
  end
end
