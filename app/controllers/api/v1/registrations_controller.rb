class Api::V1::RegistrationsController < ApplicationController
	skip_before_filter :verify_authenticity_token!
	before_filter :authenticate_user!, :except => [:create]

	def create
		user = User.new(user_params)
		if user.save
			render :json => {:success => true,
							:id => user.id,
							:email => user.email,
							:mobile_no => user.mobile_no,
							:user_name => user.user_name,
							:full_name => user.full_name,
							:old_card_no => user.old_card_no,
							:marital_status => user.marital_status,
							:address => user.address,
							:birth_date => user.birth_date,
							:auth_token => user.authentication_token},
							:status => 201
		else
			warden.custom_failure!
			render :json=> user.errors, :status=>422
		end
	end

	private
	def user_params
		params.require(:user).permit(:email,:password,:user_name,:mobile_no,:full_name,:old_card_no,:marital_status,:address,:birth_date)
	end
end
