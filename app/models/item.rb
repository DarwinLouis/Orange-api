class Item < ActiveRecord::Base
	before_save :create_url
	validates_presence_of :name, :point, :branch, :image
	has_attached_file :image, :path => ":rails_root/public/catalog/:filename"

	def create_url
		self.image_path = "/catalog/#{self.image_file_name}"
	end
end
