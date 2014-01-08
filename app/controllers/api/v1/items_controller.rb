class Api::V1::ItemsController < ApplicationController 

	def index
		render :json => Item.all, :status => 201
	end

	def create
		item = Item.create(item_param)

		if item.save
			render :json => {:success => true, :item => item}, :status => 201
		else
			render :json => {:errors => item.errors}, :status => 402
		end
	end

	private
	def item_param
		params.required(:item).permit(:image,:name,:point,:branch)
	end
end
