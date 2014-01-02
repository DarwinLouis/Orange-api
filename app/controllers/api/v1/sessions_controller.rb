class Api::V1::SessionsController < ApplicationController
	before_filter :authenticate_user!, :except => [:create, :destroy]

	def create
		
	end
	
	def destroy

	end
end
