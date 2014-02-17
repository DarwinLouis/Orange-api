class Api::V1::NotificationsController < ApplicationController

	def index
		render :json => Notification.all
	end

	def create

		notification = Notification.new

		notification.send_message params[:notification][:description]
		
		if notification.save
			render :json => notification, :status => 201
		else
			render :json => {:errors => notification.errors}, :status => 422
		end

	end

	private

	def notification_param
		params.required(:notification).permit(:description, :isActive)
	end

end
