# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    status "MyString"
    item_id 1
    user_id 1
  end
end
