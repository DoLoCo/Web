# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donation do
    user nil
    bank_account nil
    campaign nil
    amount 1
  end
end
