class Api::V1::RegistrationsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :authenticate_user!, :except => [:create, :destroy]
	def create
		user = User.new(user_params)
		if user.save
			render :json => {:success => true,
							:email => user.email,
							:mobile_no => user.mobile_no,
							:user_name => user.user_name,
							:full_name => user.full_name,
							:old_card_no => user.old_card_no,
							:auth_token => user.authentication_token},
							:status => 201
		else
			warden.custom_failure!
			render :json=> user.errors, :status=>422
		end
	end

	private
	def user_params
		params.require(:user).permit(:email,:password,:user_name,:mobile_no,:full_name,:old_card_no)
	end
end
