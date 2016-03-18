class MicropostUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gravatar_url

  def gravatar_url
    "https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(object.email.downcase)}?s=50"
  end

end
