class Promo < ActiveRecord::Base
	validates_presence_of :name, :description, :branch_id
end
