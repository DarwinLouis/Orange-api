class Credit < ActiveRecord::Base
	before_save :compute_point
	validates_presence_of :reference_no, :amount, :branch_id, :membership_id

	belongs_to :membership

	def compute_point
		self.point = amount / 50
	end
end
