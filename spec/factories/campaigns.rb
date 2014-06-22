# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign do
    organization nil
    title "MyString"
    description "MyText"
    target 1
    end_date "2014-06-22"
  end
end
