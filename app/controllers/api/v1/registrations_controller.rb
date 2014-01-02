class Api::V1::RegistrationsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :authenticate_user!, :except => [:create, :destroy]
	def create
		user = User.new(user_params)
		if user.save
			render :json => {:success => true,
							:data => user,
							:auth_token => user.authentication_token},
							:status => 201
		else
			warden.custom_failure!
			render :json=> user.errors, :status=>422
		end
	end

	private
	def user_params
		params.require(:user).permit(:email,:password)
	end
end
