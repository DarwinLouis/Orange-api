class Api::V1::PasswordsController < ApplicationController 

	def request_reset
		user = User.find_by_email(params[:email])
		user.send_password_reset if user
		render :json => {:success => true}, :status => 201
	end

	def reset_password
		user = User.find(params[:user][:id])

		return invalid_param unless user
		
		if user.update_attributes(password_param)
			render :json => {:success => true}, :status => 201
		else
			render :json => {:errors => user.errors}, :status => 402
		end

	end

	private

	def password_param
		params.required(:user).permit(:password, :password_confirmation)
	end

	def invalid_param
		render :json => {:success => false}, :status => 402
	end

end
