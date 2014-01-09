require 'spec_helper'

describe User do
	it "create membership upon saving" do
		user = create(:user)
		user.membership = build(:membership)
		user.membership.should_not eq(nil)
	end
end
