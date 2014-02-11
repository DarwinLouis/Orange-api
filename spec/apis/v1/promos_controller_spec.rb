require 'spec_helper'

describe Api::V1::PromosController, :type => :api do

	before :each do
		@url = "/api/v1/promos"
	end
	context "create" do

		it "successfull save" do
			post @url, {:promo => {:name => 'cool name',:description => 'some long description', :branch_id => 1}}, sign_in_as_a_valid_user 

			result = Promo.find_by name: 'cool name'

			expect = {:success => true, :promo => result}

			last_response.body.should eql(expect.to_json)

			last_response.status.should eql(201)
		end

		it "return 402 with missing parameter" do
			
			post @url, {:promo => {:name => ''}}, sign_in_as_a_valid_user 

			last_response.status.should eql(402)
		
		end
	end

	it "return list of promos" do

		2.times {create(:promo)}

		get @url , {}, sign_in_as_a_valid_user

		last_response.status.should eql(200)
	

		result = JSON.parse(last_response.body)

		result['promos'].length.should eql(2)

	end
	it "returns all promos within branches" do

		branch = create(:branch)
		
		2.times {create(:promo, branch_id:branch.id)}

		url = "/api/v1/promos/branches/#{branch.id}"

		get "#{url}.json", {} , sign_in_as_a_valid_user 

		last_response.status.should eql(200)


		result = JSON.parse(last_response.body)

		result['promos'].length.should eql(2)

	end
end
