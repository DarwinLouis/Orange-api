require 'spec_helper'

describe Api::V1::NotificationsController , :type => :api do
	context "create" do
		let(:url) {'/api/v1/notifications'}

		it "successfully notifications" do

			post "#{url}.json", {:notification => {:description => 'some', :isActive => true}}, sign_in_as_a_valid_user

			last_response.status.should eql(201)

		end
		
		it "error with invalid notifications" do 

			post "#{url}.json", {:notification => {:description => '', :isActive => true}}, sign_in_as_a_valid_user

			last_response.status.should eql(422)

		end

	end

	it "returns all notifications order by date asc" do

		2.times { create(:notification) }

		get "/api/v1/notifications", {}, sign_in_as_a_valid_user

		expect = JSON.parse(last_response.body)
		
		expect['notifications'].length.should eql(2)

	end

end


