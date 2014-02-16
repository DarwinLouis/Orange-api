class Api::V1::VouchersController < ApplicationController 

	def index
		render :json =>Voucher.where(:status => params[:status])
	end

	def show 
		render :json => Voucher.find(params[:id])
	end

	def claim_voucher

			voucher = Voucher.find_by_claim_code(params[:voucher][:claim_code])

			return voucher_not_found unless voucher

			if voucher.close_voucher 
				render :json =>	voucher, :status => 200
			else
				render :json => {:error => voucher.errors}, :status => 422
			end

	end

	def create
		voucher = Voucher.new(voucher_param)
		if voucher.save
			render :json => {:success => true, :voucher => {
							:id => voucher.id,
							:claim_id => voucher.claim_id,
							:claim_code => voucher.claim_code, 
							:item_id => voucher.item_id,
							:expiration_date => voucher.expiration_date.strftime('%m/%d/%Y'),
							:user_id => voucher.user_id}}, :status => 201
		else
			render :json => {:errors => voucher.errors}, :status => 402
		end
	end

	protected
	def voucher_not_found
		render :json => {:errors => 'Voucher not found'}, :status => 422
	end

	private
	def voucher_param
		params.required(:voucher).permit(:claim_id,:item_id, :user_id)
	end

end
