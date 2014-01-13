class Api::V1::PromosController < ApplicationController

	def show
		render :json => Promo.all
	end

	def create
		promo = Promo.new(promo_param)

		if promo.save
			render :json => {:success => true, :promo => promo}, :status => 201
		else
			render :json => {:success => false, :errors => promo.errors}, :status => 402
		end
	end
	
	private
	
	def promo_param
		params.required(:promo).permit(:name, :description, :branch_id)
	end
end
