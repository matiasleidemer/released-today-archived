# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album do
  describe '.create_from_spotify' do
    let(:artist) { create(:artist) }
    let(:payload) do
      {
        spotify_id: '1q2w3e',
        name: 'Cool To Be You',
        image_url: 'image.url',
        number_of_tracks: 13,
        released_at: Date.new(2012, 5, 8),
        metadata: '{}'
      }
    end

    it 'creates a new album using the spotify payload and artist' do
      album = described_class.create_from_spotify(payload, artist: artist)

      expect(album.artist).to eql(artist)
      expect(album.spotify_id).to eql(payload[:spotify_id])
      expect(album.name).to eql(payload[:name])
      expect(album.image_url).to eql(payload[:image_url])
      expect(album.number_of_tracks).to eql(payload[:number_of_tracks])
      expect(album.released_at).to eql(payload[:released_at])
      expect(album.metadata).to eql(payload[:metadata])
    end
  end

  describe '#followers' do
    subject(:album) { create(:album, artist: artist) }

    let(:artist) { create(:artist) }
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }

    it "returns the album artist's followers" do
      artist.users << user
      expect(album.followers).to eq([user])
    end
  end

  describe '#released_today?' do
    it 'returns true when the album is released today' do
      album = build_stubbed(:album, released_at: Time.zone.today)
      expect(album.released_today?).to be(true)
    end

    it 'returns true if the album was released yesterday' do
      album = build_stubbed(:album, released_at: Time.zone.yesterday)
      expect(album.released_today?).to be(true)
    end

    it 'returns false if the album was released before yesterday' do
      album = build_stubbed(:album, released_at: Time.zone.today - 2.days)
      expect(album.released_today?).to be(false)
    end
  end
end
