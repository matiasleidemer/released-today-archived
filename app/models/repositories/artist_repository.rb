module Repositories
  class ArtistRepository
    attr_reader :model

    delegate :all, :find, :find_each, to: :model

    def initialize(model = Artist)
      @model = model
    end

    def create_or_update(data)
      record = model.find_or_initialize_by(spotify_id: data[:spotify_id]) do |instance|
        instance.name     = data[:name]
        instance.metadata = data[:metadata]
      end

      record.save
      record
    end

    def stale
      model.where("updated_at < ?", Time.zone.now.yesterday)
    end
  end
end
