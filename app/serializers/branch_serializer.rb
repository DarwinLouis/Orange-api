class BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :longitude, :latitude, :links
	def links
		{:promos => "/api/v1/promos/branches/#{object.id}"}
	end
end
