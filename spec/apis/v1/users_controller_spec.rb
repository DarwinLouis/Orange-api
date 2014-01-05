require 'spec_helper'

describe Api::V1::UsersController, :type => :api do
	#include Warden::Test::Helpers
	#include Devise::TestHelpers

	before :each do
		@user = create(:user)
	end

	context "update" do
		let(:url) {"/api/v1/registrations"}
		
		it "successfully update" do

			param = {
						:id => @user.id,
						:full_name => 'updated',
						:email=>'newemail@yahoo.com',
						:mobile_no => '00998887',
						:user_name => 'newbt', 
						:old_card_no => 'updated'
					}

			put "#{url}.json", {:user => param}, sign_in_as_a_valid_user 

			user = User.find_by_id(@user.id)

			expected = {:sucess => true, :user=>{:id => user.id,
												:full_name => user.full_name,
												:email => user.email,
												:mobile_no => user.mobile_no,
												:user_name => user.user_name,
												:old_card_no => user.old_card_no}}

			last_response.body.should eql(expected.to_json)

			last_response.status.should eql(201)
			
		end
		
	end
end
