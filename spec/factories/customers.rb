FactoryBot.define do
  factory :customer do
    user { nil }
    nif { "MyString" }
    name { "MyString" }
    surname1 { "MyString" }
    surname2 { "MyString" }
    phone { "MyString" }
    address { "MyString" }
    city { "MyString" }
    postal_code { "MyString" }
    province { "MyString" }
  end
end
