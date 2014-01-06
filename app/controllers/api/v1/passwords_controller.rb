class Api::V1::PasswordsController < ApplicationController 

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
