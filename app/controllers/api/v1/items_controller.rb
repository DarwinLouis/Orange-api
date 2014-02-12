class Api::V1::ItemsController < ApplicationController 

	def index
		render :json => Item.all, :status => 200
	end

	def create

		item = Item.new

		image = params[:image]

		item.image = image
		item.name = params[:name]
		item.branch = params[:branch]
		item.point = params[:point]

		if item.save
			render :json => {:item => item}, :status => 201
		else
			render :json => {:errors => item.errors}, :status => 402
		end
	end

	def update
		item = Item.find(params[:id])

		item.image = params[:image]
		item.name = params[:name]
		item.branch = params[:branch]
		item.point = params[:point]
		
		if item.save
			render :json => {:item => item}, :status => 200
		else
			render :json => {:errors => item.errors}, :status => 422
		end

	end

	private
	def item_param
		params.required(:item).permit(:image,:name,:point,:branch)
	end
end
