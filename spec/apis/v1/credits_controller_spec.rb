require 'spec_helper'

describe Api::V1::CreditsController, :type => :api do
	
	
	describe "#crete" do
		
		let(:url) {"api/v1/credits"}

		it "successfully create credit" do

			post "#{url}.json", {:credit => {:reference_no => '1',
											:membership_id => 1,
											:branch_id => 1,
											:amount => 99.99, 
											}}, sign_in_as_a_valid_user

			credit = Credit.find_by reference_no: '1'

			expect = {:success => true, :credit => credit}

			last_response.status.should eql(201)

			last_response.body.should eql(expect.to_json)


		end
		
		it "does not with ivalid param successfully create credit" do

			post "#{url}.json", {:credit => {:reference_no => '',
											:membership_id => '',
											:branch_id => '',
											:amount => '', 
											}}, sign_in_as_a_valid_user

			last_response.status.should eql(402)

		end

	end

	describe "#show" do

		let(:membership) { create(:membership) }

		it "successfully get the aggregate credits " do

			2.times { create(:credit, membership_id: membership.id)}

			get "/api/v1/credits/#{membership.user_id}", {}, sign_in_as_a_valid_user

			result = Credit.where(membership_id: membership.id).sum(:point)

			expect = {:success => true, :points => {:total => result}}

			last_response.body.should eql(expect.to_json)

		end
		
		it "does not successfully get the aggregate credits with invalid membership" do

			get "/api/v1/credits/400", {}, sign_in_as_a_valid_user

			last_response.status.should eql(402)
			
		end

	end

end
