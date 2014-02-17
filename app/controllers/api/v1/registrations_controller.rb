class Api::V1::RegistrationsController < ApplicationController
	skip_before_filter :verify_authenticity_token!
	before_filter :authenticate_user!, :except => [:create]

	def create

		user = User.new(user_params)

		user.membership = Membership.new

		if user.save
			format = user.old_card_no == 'CMS' ? cms_format(user) : user_format(user)
			render :json => format, :status => 201
		else
			warden.custom_failure!
			render :json=> user.errors, :status=>422
		end

	end

	private

	def cms_format(user)
		return {
					:user =>{:id => user.id,
					:email => user.email,
					:user_name => user.user_name,
					:full_name => user.full_name,
					:old_card_no => user.old_card_no,
					:auth_token => user.authentication_token 
					}
				}
	end

	def user_format(user)
		return {
					:success => true, 
					:user =>{:id => user.id,
					:email => user.email,
					:mobile_no => user.mobile_no,
					:user_name => user.user_name,
					:full_name => user.full_name,
					:old_card_no => user.old_card_no,
					:marital_status => user.marital_status,
					:address => user.address,
					:birth_date => user.birth_date},
					:membership => {:expiration_date => user.membership.expiration_date},
					:auth_token => user.authentication_token 
			}
	end

	def user_params
		params.require(:user).permit(:email,:password,
																 :user_name,
																 :mobile_no,
																 :full_name,
																 :old_card_no,
																 :marital_status,
																 :address,:birth_date
																)
	end
end
