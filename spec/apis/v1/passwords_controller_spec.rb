require 'spec_helper'

describe Api::V1::PasswordsController, :type => :api do

	before :each do
		@user = create(:user)
	end

	it "email user when requesting password reset" do

		post "/api/v1/passwords/request_reset", {:email => @user.email}, sign_in_as_a_valid_user

		result = {:success => true}

		last_response.status.should eql(201)
		last_response.body.should eql(result.to_json)

		last_email.to.should include(@user.email)
		
	end
	
	it "does not email invalid user when requesting password reset" do

		post "/api/v1/passwords/request_reset", {:email => "nobody@example.com"}, sign_in_as_a_valid_user

		result = {:success => true}

		last_response.status.should eql(201)
		last_response.body.should eql(result.to_json)

		last_email.should be_nil 
		
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
