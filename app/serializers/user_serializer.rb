class UserSerializer < ActiveModel::Serializer
  attributes :id , :full_name, :email, :user_name
end