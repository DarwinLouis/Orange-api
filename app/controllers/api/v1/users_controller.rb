class Api::V1::UsersController < ApplicationController

	def update
		user = User.find_by_id(params[:user][:id]) 

		if user.update_attributes(user_param)
			
			render :json => {:sucess => true, :user=>{:id => user.id,
												:full_name => user.full_name,
												:email => user.email,
												:mobile_no => user.mobile_no,
												:user_name => user.user_name,
												:marital_status => user.marital_status,
												:address => user.address,
												:birth_date => user.birth_date,
												:old_card_no => user.old_card_no}}, :status => 201
		else
			render :json => user.errors 
		end

	end

	private
	def user_param
		params.require(:user).permit(:user_name,:mobile_no,:full_name,:old_card_no,:marital_status,:address,:birth_date)
	end

	def invalid
		render :json => {:success => false}
	end

end
