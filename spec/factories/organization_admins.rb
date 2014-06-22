# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_admin do
    user nil
    organization nil
  end
end
