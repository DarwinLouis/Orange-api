class Api::V1::UsersController < ApplicationController

	def index
		render :json => User.where(:old_card_no => 'CMS')
	end

	def show
		user = User.find(params[:id])
		if user
			
			render :json => {	:user=> {:id => user.id, 
												:full_name => user.full_name,
												:address => user.address,
												:birth_date => user.birth_date,
												:email => user.email,
												:marital_status => user.marital_status,
												:mobile_no =>user.mobile_no,
												:old_card_no => user.old_card_no}}, :status => 201
			
		else
			render :json => {:errors => user.errors}, :status => 402
		end
	end

	def update
		user = User.find_by_id(params[:user][:id]) 

		if user.update_attributes(user_param)
			format = user.old_card_no == 'CMS' ? cms_format(user) : user_format(user)
			render :json => format, :status => 201
		else
			render :json => user.errors 
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
		return {:sucess => true, :user=>{:id => user.id,
												:full_name => user.full_name,
												:email => user.email,
												:mobile_no => user.mobile_no,
												:user_name => user.user_name,
												:marital_status => user.marital_status,
												:address => user.address,
												:birth_date => user.birth_date,
												:old_card_no => user.old_card_no}}
	end

	def user_param
		params.require(:user).permit(:user_name,:mobile_no,:full_name,:old_card_no,:marital_status,:address,:birth_date)
	end

	def invalid
		render :json => {:success => false}
	end

end
