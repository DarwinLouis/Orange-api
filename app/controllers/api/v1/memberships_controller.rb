class Api::V1::MembershipsController < ApplicationController
	def show
		
		membership = Membership.find_by user_id: params[:id]
		if membership
			render :json => {:success => true, 
							:membership => {
							:full_name => membership.user.full_name,
							:member_since => membership.created_at.strftime('%m/%d/%Y'),
							:expiration_date => membership.expiration_date.strftime('%m/%d/%Y'),
							:card_no => membership.card_no,
							}}, :status => 201
		else
			render :json => {:success => false}, :status => 402
		end
	end
end
