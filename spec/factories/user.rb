FactoryGirl.define do
	sequence :email do |n|
		"email#{n}@factory.com"
	end
end

FactoryGirl.define do
	factory :user do
		email  { FactoryGirl.generate(:email)}
		password  "12345678"
		mobile_no "09198789"
		old_card_no "xx-yy-zz"
		user_name "bt"
		password_reset_token ""
	end
end
