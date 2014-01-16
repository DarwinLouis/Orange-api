require 'spec_helper'

describe Membership do
	it "create valid factory" do
		create(:membership).should be_valid
	end
	it "is invalid without user id" do
		build(:membership, user_id: nil).should_not be_valid
	end

	it "should belong to user" do
		member = create(:membership)
		#member.card_no.length.should eql(15)
		member.user.should_not eql(nil)
	end
	
	it { should belong_to(:user) }

	it { should have_many(:credits) }

	it { should validate_presence_of(:user_id) }

end
