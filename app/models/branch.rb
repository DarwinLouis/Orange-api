class Branch < ActiveRecord::Base
	validates_presence_of :name, :address, :latitude, :longitude
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?

	has_many :promos

end
