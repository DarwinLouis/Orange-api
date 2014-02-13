class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at
end
