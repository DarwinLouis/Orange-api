require 'spec_helper'

describe Promo do
	it "is invalid without name" do
		build(:promo, name: nil).should_not be_valid
	end
	
	it "is invalid without description" do
		build(:promo, description: nil).should_not be_valid
	end

	it "it invalid without branch_id" do
		build(:promo, branch_id: nil).should_not be_valid
	end
end
