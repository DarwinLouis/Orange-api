class Api::V1::MembershipsController < ApplicationController
	def show
		
		membership = Membership.find_by user_id: params[:id]
		if membership
			render :json => {:success => true, :membership => membership}, :status => 201
		else
			render :json => {:success => false}, :status => 402
		end
	end
end
