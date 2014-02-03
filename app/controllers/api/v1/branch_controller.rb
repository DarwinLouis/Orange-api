class Api::V1::BranchController < ApplicationController 

	def index
		render :json => Branch.all
	end

	def show
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

	private 
	def branch_param
		params.required('branch').permit(:name, :address, :latitude, :longitude)
	end

end
