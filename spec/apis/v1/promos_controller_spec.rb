require 'spec_helper'

describe Api::V1::PromosController, :type => :api do
	context "create" do
		let(:url) {"/api/v1/promos"}

		it "successfull save" do
			post "#{url}.json", {:promo => {:name => 'cool name',:description => 'some long description', :branch_id => 1}}, sign_in_as_a_valid_user 

			result = Promo.find_by name: 'cool name'

			expect = {:success => true, :promo => result}

			last_response.body.should eql(expect.to_json)

			last_response.status.should eql(201)
		end

		it "return 402 with missing parameter" do
			
			post "#{url}.json", {:promo => {:name => ''}}, sign_in_as_a_valid_user 

			last_response.status.should eql(402)
		
		end
	end
end
