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
						:mobile_no => '00998887',
						:user_name => 'newbt', 
						:marital_status => 'update',
						:address => 'updated address',
						:birth_date => 'update',
						:old_card_no => 'updated'
					}

			put "#{url}.json", {:user => param}, sign_in_as_a_valid_user 

			user = User.find_by_id(@user.id)

			expected = {:sucess => true, :user=>{:id => user.id,
												:full_name => user.full_name,
												:email => user.email,
												:mobile_no => user.mobile_no,
												:user_name => user.user_name,
												:marital_status => user.marital_status,
												:address => user.address,
												:birth_date => user.birth_date,
												:old_card_no => user.old_card_no}}

			last_response.body.should eql(expected.to_json)

			last_response.status.should eql(201)
			
		end

		it "successfully get one user" do

			user = create(:user)

			get "#{url + '/' + "#{user.id}"}.json", {}, sign_in_as_a_valid_user

			expect = {:success => true, :user=> {:id => user.id, 
												:full_name => user.full_name,
												:address => user.address,
												:birth_date => user.birth_date,
												:email => user.email,
												:marital_status => user.marital_status,
												:mobile_no =>user.mobile_no,
												:old_card_no => user.old_card_no}}

			result = last_response.body

			result.should eql(expect.to_json)

			last_response.status.should eql(201)

		end
		
	end
end
