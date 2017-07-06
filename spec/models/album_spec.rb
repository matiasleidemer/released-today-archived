require 'rails_helper'

RSpec.describe Album do
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

    it "returns false when the album wasn't released today" do
      album = build_stubbed(:album, released_at: Time.zone.yesterday)
      expect(album.released_today?).to eql(false)
    end
  end
end
