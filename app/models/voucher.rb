class Voucher < ActiveRecord::Base

	before_save :insure_claim_code 

	validates_presence_of :user_id, :item_id, :claim_id

	def insure_claim_code
		if claim_code.blank?
			self.claim_code = generate_claim_code 
		end
	end

	def generate_claim_code
		loop do
			code = SecureRandom.hex(5)
			break code unless Voucher.where(claim_code: code).first
		end
	end

end
