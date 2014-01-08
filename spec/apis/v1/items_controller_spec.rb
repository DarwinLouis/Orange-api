require 'spec_helper'

describe Api::V1::ItemsController , :type => :api do
	
	before :each do
		@image = Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'text/jpg')
	end

	context "Items" do
		let(:url) {"/api/v1/items" }
	
	context "create" do
		it "successfully save new item" do

			post "#{url}.json", {:item => {:image => @image ,:name => 'item 1', :point => 100, :branch => 'branch'}}, sign_in_as_a_valid_user

			item = Item.find_by name: 'item 1'

			result = {:success => true, :item => item}

			last_response.body.should eql(result.to_json)

			last_response.status.should eql(201)

		end

		it "returns error without image" do
			
			post "#{url}.json", {:item => {:image => {} ,:name => 'item 1', :point => 100, :branch => 'branch'}}, sign_in_as_a_valid_user

			item = Item.find_by name: 'item 1'


			last_response.status.should eql(402)

		end
	end

		it "returns all items" do

			2.times {FactoryGirl.create(:item,image:@image)}

			get "#{url}.json", {}, sign_in_as_a_valid_user

			last_response.status.should eql(201)

			result = JSON.parse(last_response.body)

			result['items'].length.should eql(2)

		end

	end
end
