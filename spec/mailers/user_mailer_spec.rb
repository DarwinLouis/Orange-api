require "spec_helper"

describe UserMailer do
  describe "password_reset" do
	let(:user) { create(:user, :password_reset_token => 'anything')}
    let(:mail) { UserMailer.password_reset(user) }

    it "send user a password reset url" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["from@example.com"])
      mail.body.encoded.should match(%{<a href="/password_reset/#{user.password_reset_token}">Reset Password</a>})
    end

	end
end
