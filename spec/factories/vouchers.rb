# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    status "MyString"
		claim_id "xyz"
    item_id 1
    expiration_date "2014-01-09 13:09:57"
    user_id 1
  end
end
