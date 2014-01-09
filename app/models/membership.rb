class Membership < ActiveRecord::Base
	before_save :validate_expiration_date, :generate_code_number
	
	validates_presence_of :user_id 
	belongs_to :user
	
	def validate_expiration_date
		self.expiration_date = DateTime.now + 12.month
	end

	def generate_code_number
		self.card_no = SecureRandom.hex(8) 
	end
end
