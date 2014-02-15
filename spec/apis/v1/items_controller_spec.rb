require 'spec_helper'

describe Api::V1::ItemsController , :type => :api do
	
	before :each do
		@image = Rack::Test::UploadedFile.new('spec/fixtures/images/rails.png', 'text/jpg')
	end

	context "Items" do
		let(:url) {"/api/v1/items" }
	
	context "create" do
		it "successfully save new item" do

			post "#{url}.json", {:image => @image ,:name => 'item 1', :point => 100, :branch_id => 1}, sign_in_as_a_valid_user

			item = Item.find_by name: 'item 1'

			result = {:item => item}

			#TODO please check the links property
			#last_response.body.should eql(result.to_json)

			last_response.status.should eql(201)

		end

		it "successfully update item" do 

			item = create(:item, image: @image)

			put "#{url}/#{item.id}.json", {:image => @image ,
							:name => 'update', 
							:point => 100, 
							:branch_id => 1}, sign_in_as_a_valid_user

			item = Item.find(item.id)

			item.name.should eql('update')
			item.point.should eql(100)
			item.branch_id.should eql(1)

			last_response.status.should eql(200)

		end

		it "returns error without image" do
			
			post "#{url}.json", {:item => {
								:image => {} ,
								:name => 'item 1', 
								:point => 100, 
								:branch_id => 1}
							}, sign_in_as_a_valid_user

			item = Item.find_by name: 'item 1'


			last_response.status.should eql(402)

		end
	end

		it "returns all items" do

			2.times {FactoryGirl.create(:item,image:@image)}

			get "#{url}.json", {}, sign_in_as_a_valid_user

			last_response.status.should eql(200)

			result = JSON.parse(last_response.body)

			result['items'].length.should eql(2)

		end

		it "filter items with pagination" do

			5.times { create(:item, image:@image) }

			get "/api/v1/items/search", {:q => "MyString", :page => 1, :page_limit => 5}, sign_in_as_a_valid_user

			last_response.status.should eql(200)

			result = JSON.parse(last_response.body)

			result['items'].length.should eql(5)

			#TODO
			#please check also the total count for the meta

		end

	end
end
