require 'spec_helper'

describe Api::V1::BranchesController, :type => :api do

	describe "#create" do
		let(:url) { "/api/v1/branches" }
		
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

	describe "#update" do

		let(:url) {"/api/v1/branches/"}

		it "successfully update branch" do
			
			@branch = create(:branch)
			Branch.any_instance.stubs(:geocode).returns([1,1])

			name = 'new name'
			address = 'new address'
			latitude = 1.0
			longitude = 2.0

			put "#{url}#{@branch.id}.json" , {:branch => 
																				{:name => name, 
																				:address => address, 
																				:latitude => latitude,
																				:longitude => longitude}
																			} , sign_in_as_a_valid_user

			branch = Branch.find(@branch.id)

			branch.name.should eql(name)
			branch.address.should eql(address)

			last_response.status.should eql(200)

		end
	end
	
	it "returns all branch" do

		2.times {create(:branch) }

		get "/api/v1/branches", {}, sign_in_as_a_valid_user


		last_response.status.should eql(200)

		result = JSON.parse(last_response.body)

		result['branches'].length.should eql(2)

	end

	#get branch
	it "returns single branch" do

		branch = create(:branch)
		
		get "/api/v1/branches/#{branch.id}.json", {}, sign_in_as_a_valid_user

		last_response.status.should eql(200)

		result = JSON.parse(last_response.body)

		result['branch'].should_not eql(nil)

	end
	
	it "returns branch filter by geo" do

		2.times {create(:branch)}

		get "/api/v1/branches/search", {:latitude => 1.0, :longitude => 1.0}, sign_in_as_a_valid_user
		
		last_response.status.should eql(200)

		result = JSON.parse(last_response.body)

	end

	it "successfully delete branch" do

		@branch = create(:branch)

		delete "/api/v1/branches/#{@branch.id}", {}, sign_in_as_a_valid_user

		branch = Branch.exists?(@branch.id)

		branch.should_not eql(true)

		last_response.status.should eql(200)

	end

end
