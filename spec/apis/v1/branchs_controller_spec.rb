require 'spec_helper'

describe Api::V1::BranchController, :type => :api do

	describe "#create" do
		let(:url) { "/api/v1/branch" }
		
		it "successfull create branch" do

			@name = "branch"
			@address = "address"

			post "#{url}.json", {:branch => 
														{:name => @name, 
														:address => @address, 
														:latitude => 1.0, :longitude => 1.0
													}}, sign_in_as_a_valid_user

			last_response.status.should eql(201)

			branch = Branch.find_by name: @name

			branch.name.should eql(@name)
			branch.address.should eql(@address)

		end

		it "not successfully create branch with invalid data" do

			post "#{url}.json", {:branch => 
														{:name => '', 
														:address => '', 
														:latitude => 1.0, :longitude => 1.0
													}}, sign_in_as_a_valid_user

			last_response.status.should eql(422)

		end
	end
	
	it "returns all branch" do

		2.times {create(:branch) }

		get "/api/v1/branch", {}, sign_in_as_a_valid_user


		last_response.status.should eql(200)

		result = JSON.parse(last_response.body)

		result['branch'].length.should eql(2)

	end
	
	it "returns branch filter by geo" do

		2.times {create(:branch)}

		get "/api/v1/branch/search", {:latitude => 1.0, :longitude => 1.0}, sign_in_as_a_valid_user
		
		last_response.status.should eql(200)

		result = JSON.parse(last_response.body)

	end

end
