class Item < ActiveRecord::Base
	validates_presence_of :name, :point, :branch,  :image
	has_attached_file :image, :path => ":rails_root/public/avatars/:filename"
end
