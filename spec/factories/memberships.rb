# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    expiration_date "2014-01-09 13:09:57"
    card_no "MyString"
    user_id 1
		association :user, factory: :user
  end
end
