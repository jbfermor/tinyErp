FactoryBot.define do
  factory :supplier do
    user { nil }
    nif { "MyString" }
    commercial_name { "MyString" }
    contact_person { "MyString" }
    address { "MyString" }
    city { "MyString" }
    postal_code { "MyString" }
    province { "MyString" }
  end
end
