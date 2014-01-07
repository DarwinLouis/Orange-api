class Voucher < ActiveRecord::Base

	before_save :insure_claim_code 

	validates_presence_of :user_id, :item_id

	def insure_claim_code
		self.claim_code = generate_claim_code 
	end

	def generate_claim_code
		SecureRandom.hex(10)
	end

end
