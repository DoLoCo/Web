# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bank_account do
    nickname "MyString"
    gateway_reference_id "MyString"
  end
end
