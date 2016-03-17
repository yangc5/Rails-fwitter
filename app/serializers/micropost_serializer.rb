class MicropostSerializer < ActiveModel::Serializer
  attributes :id, :content, :likes, :created_at
  has_one :user, serializer: MicropostUserSerializer
  has_many :categories, serializer: MicropostCategorySerializer
end
