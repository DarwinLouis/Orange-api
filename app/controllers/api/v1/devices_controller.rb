class Api::V1::DevicesController < ApplicationController 

	def create
			device = Device.new(device_param)
			if device.save
						render :json => {:success => true}, :status => 201
			else
				render :json => {:errors => device.errors}, :status => 402
			end
	end

	private

	def already_exist
			render :json => {:success => false, :error => 'key already exists'}, :status => 402
	end

	def device_param
		params.required(:device).permit(:key, :os_type)
	end

end
