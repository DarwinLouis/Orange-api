class Device < ActiveRecord::Base
	validates_presence_of :key, :os_type
	validates_uniqueness_of :key
end
