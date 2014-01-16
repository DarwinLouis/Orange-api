# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit do
    reference_no "MyString"
    amount "9.99"
    point 1
    membership_id 1
    branch_id 1
  end
end
