require 'spec_helper'

describe Api::V1::RegistrationsController, :type => :api do
	before :each do
		sign_in_as_a_valid_user
	end
	context "Register User" do

		let(:url) {"/api/v1/registrations"}

		it "create new user" do

			post "#{url}.json", {:user => {:email =>'123@yahoo.com', 
								:password => '12345678909',
								:full_name => 'Bernard Tolosa',
								:user_name => 'bt',
								:mobile_no => '09129383743',
								:old_card_no => '00923834974'}}

			user = User.find_by_email('123@yahoo.com')

			last_response.status.should eql(201)

			result = {:success => true, 
					:email => user.email,
					:mobile_no => user.mobile_no,
					:user_name => user.user_name,
					:full_name => user.full_name,
					:old_card_no => user.old_card_no,
					:auth_token => user.authentication_token}

			last_response.body.should eql(result.to_json)

		end
		
		it "Unsuccessfull JSON" do
			
			post "#{url}.json", {:user => {:email => '',:password => ''}}

			last_response.status.should eql(422)

			errors = {:email => ["can't be blank"],:password => ["can't be blank"]}.to_json

			last_response.body.should eql(errors)

		end
	end

	context "Update User Registration" do
		let(:url) {"/api/v1/registrations"}
		it "Successfull update" do 
  
		end
	end

end
