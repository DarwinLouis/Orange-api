require 'spec_helper'

describe Api::V1::MembershipsController , :type => :api do
	it "return membership" do
		
		membership = create(:membership)

		get "/api/v1/memberships/#{membership.user_id}", {}, sign_in_as_a_valid_user

		last_response.status.should eql(201)

		expect = {:success=> true, :membership => {:full_name => membership.user.full_name, 
													:member_since => membership.created_at.strftime('%m/%d/%Y'),
													:expiration_date => membership.expiration_date.strftime('%m/%d/%Y'),
													:card_no => membership.card_no}}.to_json

		last_response.body.should eql(expect)

	end
end
