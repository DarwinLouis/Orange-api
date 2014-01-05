module AuthenticationHelper
	def sign_in_as_a_valid_user
		user = create(:user)
		{'HTTP_AUTHORIZATION' => user.authentication_token}
	end
end

RSpec.configure do |config|
	  config.include AuthenticationHelper, :type=>:api
end
