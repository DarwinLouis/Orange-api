require 'spec_helper'

describe Api::V1::MembershipsController , :type => :api do
	it "return membership" do
		
		membership = create(:membership)

		get "/api/v1/memberships/#{membership.user_id}", {}, sign_in_as_a_valid_user

		last_response.status.should eql(201)

		expect = {:success=> true, :membership => membership}.to_json

		last_response.body.should eql(expect)

	end
end
