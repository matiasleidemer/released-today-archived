module Repositories
  class AlbumRepository
    attr_reader :model

    delegate_missing_to :@model

    def initialize(model = Album)
      @model = model
    end

    def create(data)
      record = model.new(spotify_id: data[:spotify_id]) do |instance|
        instance.artist_id        = data[:artist_id]
        instance.name             = data[:name]
        instance.image_url        = data[:image_url]
        instance.number_of_tracks = data[:number_of_tracks]
        instance.released_at      = data[:released_at]
      end

      record.save
      record
    end

    def user_releases(user)
      model
        .joins(artist: :users)
        .where('artists_users.user_id = ?', user.id)
        .order('released_at DESC').includes(:artist).limit(9)
    end
  end
end
