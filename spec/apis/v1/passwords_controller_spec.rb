require 'spec_helper'

describe Api::V1::PasswordsController, :type => :api do

	before :each do
		@user = create(:user)
	end

	context 'reset password' do
		let(:url) { "/api/v1/passwords/reset_password" }
		
		it "successfully reset password" do

			newpassword = '0987654321'

			put "#{url}.json", {:user => {:id => @user.id, :password => newpassword, :password_confirmation => newpassword}}, sign_in_as_a_valid_user

			user = User.find_by_id(@user.id)

			result = {:success => true}.to_json

			last_response.status.should eql(201)
			last_response.body.should eql(result)

		end
	end
end
