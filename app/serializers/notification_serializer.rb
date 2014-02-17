class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at
end
