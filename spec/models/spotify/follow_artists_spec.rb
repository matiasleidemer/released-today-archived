require 'rails_helper'

RSpec.describe Spotify::FollowArtists do
  subject { described_class.new(user: user, artists_ids: artists_ids) }
  let(:user) { create(:user) }
  let(:artists_ids) { %w(3JhEcBWSCPXkRMt1VK14i4 6bUJpbekaIlq2fT5FMV2mQ) }

  describe '#call' do
    it 'creates the artists' do
      VCR.use_cassette 'follow_artists' do
        expect { subject.call }.to change { Artist.count }.from(0).to(2)
      end
    end

    it 'makes the user follow the artists' do
      VCR.use_cassette 'follow_artists' do
        expect { subject.call }.to change { user.artists.count }.from(0).to(2)
      end
    end
  end
end
