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


    it "creates a new album using the spotify payload and artist" do
      album = described_class.create_from_spotify(payload, artist: artist)
      expect(album.artist).to eql(artist)
      expect(album.spotify_id).to eql('1q2w3e')
      expect(album.name).to eql('Cool To Be You')
      expect(album.image_url).to eql('image.url')
      expect(album.number_of_tracks).to eql(13)
      expect(album.released_at).to eql(Date.new(2012, 5, 8))
      expect(album.metadata).to eql('{}')
    end
  end

  describe '#followers' do
    subject      { create(:album, artist: artist) }
    let(:artist) { create(:artist) }
    let(:user)   { create(:user) }
    let(:user_2) { create(:user) }

    it "returns the album artist's followers" do
      artist.users << user
      expect(subject.followers).to eq([user])
    end
  end

  describe '#released_today?' do
    it 'returns true when the album is released today' do
      album = build_stubbed(:album, released_at: Time.zone.today)
      expect(album.released_today?).to eql(true)
    end

    it "returns true if the album was released yesterday" do
      album = build_stubbed(:album, released_at: Time.zone.yesterday)
      expect(album.released_today?).to eql(true)
    end

    it "returns false if the album was released before yesterday" do
      album = build_stubbed(:album, released_at: Time.zone.today - 2.days)
      expect(album.released_today?).to eql(false)
    end
  end
end
