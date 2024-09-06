FactoryBot.define do
  factory :worker do
    nif { "MyString" }
    name { "MyString" }
    surname1 { "MyString" }
    surname2 { "MyString" }
    address { "MyString" }
    city { "MyString" }
    postal { "MyString" }
    province { "MyString" }
    phone { "MyString" }
    user { nil }
    bio { nil }
  end
end
