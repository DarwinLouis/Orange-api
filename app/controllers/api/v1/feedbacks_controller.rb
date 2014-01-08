class Api::V1::FeedbacksController < ApplicationController

	def show
		render :json => Feedback.all, :status => 201
	end

	def create
		feedback = Feedback.new(feedback_param)

		if feedback.save
			render :json => {:success => true}, :status => 201
		else
			render :json => {:success => false, :errors => feedback.errors}, :status => 402
		end
	end
	
	private 
	def feedback_param
		params.required(:feedback).permit(:description)
	end
end
