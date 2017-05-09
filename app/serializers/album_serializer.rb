class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :released_at, :spotify_id, :image_url, :number_of_tracks

  belongs_to :artist

  class ArtistSerializer < ActiveModel::Serializer
    attributes :id, :spotify_id, :name
  end
end
