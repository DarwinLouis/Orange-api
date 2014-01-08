require 'spec_helper'

describe Feedback do
	it "is invalid without description" do
		build(:feedback, description: nil).should_not be_valid
	end
end
