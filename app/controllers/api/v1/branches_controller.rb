class Api::V1::BranchesController < ApplicationController 

	def index
		render :json => Branch.all
	end

	def show
		render :json => Branch.find(params[:id])
	end

	def search
		render :json => Branch.near([params[:latitude],params[:longitude]], 100)	
	end

	def create

		branch = Branch.new(branch_param)

		if branch.save 
			render :json => {:branch => branch}, :status => 201 
		else
			render :json => {:errors => branch.errors }, :status => 422
		end

	end

	def update
		branch = Branch.find(params[:id])

		if branch.update_attributes(branch_param)
			render :json => {:branch => branch}, :status => 200
		end
		
	end

	def destroy
		branch = Branch.find(params[:id])

		if branch.destroy
			render :json => {:branch => branch}, :status => 200
		end

	end

	private 
	def branch_param
		params.required('branch').permit(:name, :address, :latitude, :longitude)
	end

end
