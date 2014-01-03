require 'spec_helper'
describe Api::V1::SessionsController, :type => :api do
		
	context "Sign in" do
		let(:url) {"/api/v1/sessions"}

		it "Valid sign in" do

			email = 'btolosa@yahoo.com'
			password = '123456789'

			#post "#{url}.json", {:email => email, :password => password}

			#response.status.should eql(200)

		end
	end
end
