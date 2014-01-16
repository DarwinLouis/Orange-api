class Api::V1::CreditsController < ApplicationController
	def create
		credit = Credit.new(credit_param)
		if credit.save
			render :json => {:success => true, :credit => credit}, :status => 201
		else
			render :json => {:errors => credit.errors}, :status => 402
		end
	end
	
	private

	def credit_param
		params.required(:credit).permit(:reference_no, :membership_id, :branch_id, :amout)
	end
end
