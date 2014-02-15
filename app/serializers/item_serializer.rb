class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_path, :point, :branch_id
end
