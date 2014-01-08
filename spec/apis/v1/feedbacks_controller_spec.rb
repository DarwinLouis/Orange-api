require 'spec_helper'

describe Api::V1::FeedbacksController, :type => :api do
	
	context "Feedback" do
		let(:url) { '/api/v1/feedbacks' }

		it "successfully return valid json" do
		
			post "#{url}.json", {:feedback => {:description => "cool"}}, sign_in_as_a_valid_user

			last_response.status.should eql(201)

		end

		it "unssuccessfully return json" do
			
			post "#{url}.json", {:feedback => {:description => ""}}, sign_in_as_a_valid_user
			
			last_response.status.should eql(402)

		end

		it "returns list of feedback" do
	
			2.times { create(:feedback) }

			get "#{url}.json", {}, sign_in_as_a_valid_user

			result = JSON.parse last_response.body

			result['feedbacks'].should be_kind_of(Array)
			result.length.should eql(1)

		end

	end
end
