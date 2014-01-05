module ControllerMacros
	def login_user
		before(:each) do
			puts 'yo'
			@request.env["devise.mapping"] = Devise.mappings[:user]
			user = FactoryGirl.create(:user)
			sign_in user
		end
	end
end
