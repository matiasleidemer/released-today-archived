# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spotify::UserTopArtists do
  subject(:user_top_artists) { described_class.new(user) }

  let(:client) { instance_double('RSpotify::User') }
  let(:user) { instance_double('User') }

  let(:dinosaur_jr) { build(:dinosaur_jr) }
  let(:descendents) { build(:descendents) }
  let(:hot_water_music) { build(:hot_water_music) }

  describe '#all_time_ranges' do
    before do
      allow(client)
        .to receive(:top_artists)
        .with(limit: 50, time_range: :short_term)
        .and_return([dinosaur_jr])

      allow(client)
        .to receive(:top_artists)
        .with(limit: 50, time_range: :medium_term)
        .and_return([descendents])

      allow(client)
        .to receive(:top_artists)
        .with(limit: 50, time_range: :long_term)
        .and_return([dinosaur_jr, hot_water_music])
    end

    it "returns the user's top artists" do
      artists = user_top_artists.all_time_ranges(client: client)

      expect(artists.size).to be(3)
      expect(artists.map(&:name))
        .to match(['Dinosaur Jr.', 'Descendents', 'Hot Water Music'])
    end
  end
end
