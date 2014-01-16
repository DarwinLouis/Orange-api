class Api::V1::CreditsController < ApplicationController

	def show
		membership = Membership.find_by_user_id(params[:id])
		return invalid_param unless membership
		if membership
			render :json => {:success => true, :points=> {:total => membership.total_points}}
		end
	end

	def create
		credit = Credit.new(credit_param)
		if credit.save
			render :json => {:success => true, :credit => credit}, :status => 201
		else
			invalid_param
		end
	end
	
	private

	def credit_param
		params.required(:credit).permit(:reference_no, :membership_id, :branch_id, :amount)
	end

	def invalid_param
		render :json => {:success => false}, :status => 402
	end
end
