require 'spec_helper'

describe Api::V1::VouchersController, :type => :api do

	before :each do
		#@voucher = create(:voucher)
	end

	context "Create new Voucher" do 
		let(:url) { "/api/v1/vouchers" }

	it "successfully create new vouchers" do

		post "#{url}.json", {:voucher => {:claim_id => 'xyz', :item_id => 1, :user_id => 1}}, sign_in_as_a_valid_user

		voucher = Voucher.find_by item_id: 1 

		expect = {:success => true, :voucher => {
						:id => voucher.id,
						:claim_id => voucher.claim_id,
						:claim_code => voucher.claim_code,
						:item_id => voucher.item_id,
						:user_id => voucher.user_id}}

		last_response.status.should eql(201)
		
		last_response.body.should eql(expect.to_json)

	end
	
	it "successfull return serialized object" do
		
		@voucher = create(:voucher)


		get "#{url + "/#{@voucher.id}"}.json", {}, sign_in_as_a_valid_user

		result = Voucher.find(@voucher.id)

		expect = {:voucher => {:id =>result.id, :claim_code => result.claim_code}}.to_json

		last_response.body.should eql(expect)

	end

	end
end
