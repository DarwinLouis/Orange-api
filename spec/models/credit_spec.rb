require 'spec_helper'

describe Credit do
	it "has a valid factory" do
		build(:credit).should be_valid
	end

	it "is invalid without reference no" do
		build(:credit, reference_no: nil).should_not be_valid
	end

	it "is invalid without amout" do
		build(:credit, amount: nil).should_not be_valid
	end

	it "is invalid without branch" do
		build(:credit, branch_id:nil).should_not be_valid
	end

	it "is invalid without membership" do
		build(:credit, membership_id:nil).should_not be_valid
	end

	it "auto compute earn point via amout" do
		credit = create(:credit, point:nil)

		credit.point.should_not eql(nil) 
	end

	it { should belong_to(:membership) }
	
end
