require 'spec_helper'

describe Voucher do
	
	context "Voucher Creation" do

	let(:voucher) { create(:voucher) }

	it "has a valid factory" do
		voucher.should be_valid
	end

	it "is invalid without a user id" do
		build(:voucher, user_id: nil).should_not be_valid
	end

	it "is invalid without a item id" do
		build(:voucher, item_id: nil).should_not be_valid
	end

	it "return status code as pending upon creation" do
		voucher.claim_code.should_not eql(nil)
	end

	it "is invalid without a claim id" do
		build(:voucher, claim_id:nil).should_not be_valid
	end

	it "should generate 1 month expiration data" do
		voucher = create(:voucher, expiration_date: nil)

		voucher.expiration_date.should_not eql(nil)

	end

	it "return status pending after saving" do
		voucher = create(:voucher, status: nil)

		voucher.status.should_not eql(nil)
	end

	end
end
