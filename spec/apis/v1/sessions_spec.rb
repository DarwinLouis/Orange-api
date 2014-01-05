require 'spec_helper'

describe Api::V1::SessionsController, :type => :api do

	before :each do
		@user ||= create(:user)
	end

	context "Sign in" do
		let(:url) {"/api/v1/sessions"}

		it "successfully sign in" do

			email = @user.email
			password = '12345678'

			post "#{url}.json", {:email => email, :password => password}

			last_response.status.should eql(201)

			result = {:success => true, :access_token => @user.authentication_token,:token_type => 'bearer', 
						:user => {:id => @user.id}}.to_json
		
			last_response.body.should eql(result)

		end

		it "return invalid login" do
			
			email = 'someguy@yahoo.com'
			password = '12345678'

			post "#{url}.json", {:email => email, :password => password}

			last_response.status.should eql(401)
			
		end
	end
end
