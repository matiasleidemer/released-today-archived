module Repositories
  class ArtistRepository
    attr_reader :model

    delegate_missing_to :@model

    def initialize(model = Artist)
      @model = model
    end

    def create_or_update(data)
      record = model.find_or_initialize_by(spotify_id: data[:spotify_id])
      record.name = data[:name]
      record.metadata = data[:metadata]
      record.save

      record
    end

    def stale
      model
        .where("updated_at < ?", 22.hours.ago)
        .where("disabled_at is null")
    end
  end
end
