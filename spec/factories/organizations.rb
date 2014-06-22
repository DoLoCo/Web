# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "MyString"
    website "MyString"
    description "MyText"
    address_line1 "MyString"
    address_line2 "MyString"
    city "MyString"
    state "MyString"
    postal_code "MyString"
    lat "9.99"
    lng "9.99"
  end
end
