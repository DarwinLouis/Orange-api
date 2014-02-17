require 'spec_helper'

describe Notification do
	let(:notification) {create(:notification)}

	it "deliver messages to user" do
		notification.send_message "fake message"
	end

	it { should validate_presence_of(:description) }

end
