class Voucher < ActiveRecord::Base


	before_save :insure_claim_code, :generate_expiration_date

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
	
	def generate_expiration_date
		self.expiration_date = DateTime.now + 1.month
	end

end
