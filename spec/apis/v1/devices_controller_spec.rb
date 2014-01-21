require 'spec_helper'

describe Api::V1::DevicesController, :type => :api do

	describe "#create" do

		let(:url) { "/api/v1/devices" }

		it "should be successfully create a new device" do

			post "#{url}.json" , {:device => {:key => 'somekey', :os_type => 'iOS'}}, sign_in_as_a_valid_user
			
			expect = {:success => true}.to_json

			device = Device.find_by key: 'somekey'

			device.should_not eql(nil)
			device.key.should eql('somekey')
			device.os_type.should eql('iOS')
			last_response.status.should eql(201)
			last_response.body.should eql(expect)

		end

		it "should not successfully create a new device with invalid parameter" do

			post "#{url}.json", {:device => {:key => ''}}, sign_in_as_a_valid_user

			last_response.status.should eql(402)

		end

	end

end
