module AuthenticationHelper
	def sign_in_as_a_valid_user
		
	end
end

RSpec.configure do |config|
	  config.include AuthenticationHelper, :type=>:api
end
