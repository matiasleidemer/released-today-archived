class ArtistSerializer < ActiveModel::Serializer
  attributes :name, :spotify_id, :image_url, :metadata
end
