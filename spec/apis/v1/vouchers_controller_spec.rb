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
						:expiration_date => voucher.expiration_date.strftime('%m/%d/%Y'),
						:user_id => voucher.user_id}}

		last_response.status.should eql(201)
		
		last_response.body.should eql(expect.to_json)

	end
	
	it "successfull return serialized object" do
		
		@voucher = create(:voucher)

		get "#{url + "/#{@voucher.id}"}.json", {}, sign_in_as_a_valid_user

		voucher = Voucher.find(@voucher.id)

		expect = {:voucher => {
						:id => voucher.id,
						:claim_id => voucher.claim_id,
						:claim_code => voucher.claim_code,
						:item_id => voucher.item_id,
						:created_at => voucher.created_at,
						:updated_at => voucher.updated_at, 
						:status => voucher.status }}.to_json

		last_response.body.should eql(expect)

	end

	it "successfully claim voucher" do

		voucher = create(:voucher)

		post "#{url}/claims", {:voucher => {:claim_code => voucher.claim_code}}, sign_in_as_a_valid_user

		last_response.status.should eql(200)

		result = Voucher.find_by claim_code: voucher.claim_code

		result.status.should eql("closed")

	end

	it "return error if voucher not found" do
		voucher = create(:voucher)

		post "#{url}/claims", {:claim_code => 'yyy'}, sign_in_as_a_valid_user

		result = Voucher.find_by claim_code: voucher.claim_code

		result = JSON.parse(last_response.body)

		result['errors'].should eql('Voucher not found')

	end

	it "return all closed voucher" do

		2.times {create(:voucher, status:'closed')}

		get "#{url}", {:status => 'closed'}, sign_in_as_a_valid_user

		result = JSON.parse(last_response.body)

		result['vouchers'].count.should eql(2)

	end

	it "return all voucher by user" do

		2.times {create(:voucher, status:'closed')}

		get "#{url}", {:user_id => 1}, sign_in_as_a_valid_user

		result = JSON.parse(last_response.body)

		result['vouchers'].count.should eql(2)

	end

	end
end
