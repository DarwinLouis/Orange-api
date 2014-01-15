require 'spec_helper'

describe User do
	let(:user) {create(:user)}
	it "create membership upon saving" do
		user.membership = build(:membership)
		user.membership.should_not eq(nil)
	end

	describe "#password reset" do
		it "generates a unique password_reset_token each time" do
			user.send_password_reset
			last_token = user.password_reset_token
			user.send_password_reset
			user.password_reset_token.should_not eql(last_token)
		end

		it "saves the time the password reset was sent" do
			user.send_password_reset
			user.reload.password_reset_sent_at.should be_present
		end

		it "delivers email to user" do
			user.send_password_reset
			last_email.to.should include(user.email)
		end
	end

	
end
