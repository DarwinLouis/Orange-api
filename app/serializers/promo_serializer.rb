class PromoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :branch_id
end
