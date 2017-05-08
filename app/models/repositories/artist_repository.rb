module Repositories
  class ArtistRepository
    attr_reader :model

    def initialize(model = Artist)
      @model = model
    end

    def find(id)
      model.find(id)
    end

    def create_or_update(data)
      record = model.find_or_initialize_by(spotify_id: data[:spotify_id]) do |instance|
        instance.name     = data[:name]
        instance.metadata = data[:metadata]
      end

      record.save
      record
    end
  end
end
