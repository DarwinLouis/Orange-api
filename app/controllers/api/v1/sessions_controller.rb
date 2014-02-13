class Api::V1::SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token!
	before_filter :authenticate_user! , :except => [:create, :destroy]

	def create

		user = User.find_for_database_authentication(:email => params[:email])

		return invalid_login_attemp unless user

		if user.valid_password?(params[:password])
			
			sign_in(:user,user)

			render :json => {:success => true,
							:access_token => user.authentication_token,
							:token_type => "bearer",
							:user => {:id => user.id, :full_name => user.full_name},
							:membership => {:id => user.membership.id,
														:card_number => user.membership.card_no,
														:member_since => user.membership.created_at.strftime('%m/%d/%Y'),
														:expiration_date => user.membership.expiration_date.strftime('%m/%d/%Y')
														}
							},:status => 201
			return
		end
		invalid_login_attemp
	end
	
	def destroy

	end

	protected
	def invalid_login_attemp
		render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
	end
end
