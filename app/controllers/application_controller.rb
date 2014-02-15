class ApplicationController < ActionController::API
	include ActionController::MimeResponds
	include ActionController::StrongParameters

	before_filter :authenticate_user_from_token!

	# This is Devise's authentication
	#before_filter :authenticate_user!

	def authenticate_user_from_token!
		Rails.logger.info params

		auth_token = request.env['HTTP_AUTHORIZATION']

		user = User.find_by_authentication_token(auth_token)

		if user
			sign_in user, store:false
		end

	end

end

