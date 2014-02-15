class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_path, :point, :branch_id, :links
	def links
		{:branch => "/api/v1/branches/#{object.branch_id}"}
	end
end
