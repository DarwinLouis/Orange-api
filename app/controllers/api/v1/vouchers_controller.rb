class Api::V1::VouchersController < ApplicationController 

	def show 
		@voucher = Voucher.find(params[:id])
		render :json => @voucher 
	end

	def create
		voucher = Voucher.new(voucher_param)
		if voucher.save
			render :json => {:success => true, :voucher => {
							:id => voucher.id,
							:claim_code => voucher.claim_code, 
							:item_id => voucher.item_id,
							:user_id => voucher.user_id}}, :status => 201
		else
			render :json => {:errors => voucher.errors}, :status => 402
		end
	end

	private
	def voucher_param
		params.required(:voucher).permit(:item_id, :user_id)
	end

end
