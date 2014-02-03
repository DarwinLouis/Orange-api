class BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :longitude, :latitude
end
