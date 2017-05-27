require 'rails_helper'

RSpec.describe Spotify::ReleasesSyncer do
  let(:artist) { create(:artist) }
  let(:user)   { create(:user) }

  before do
    artist.users << user
    artist.update_attribute(:updated_at, Time.zone.now - 2.days)
  end

  describe '.call' do
    it "saves the artist's latest releases" do
      VCR.use_cassette 'releases_syncer' do
        expect { described_class.call }
          .to change { artist.albums.count }.from(0).to(2)
      end
    end

    it "creates new release notifications for users that follow the artist" do
      VCR.use_cassette 'releases_syncer' do
        expect { described_class.call }
          .to change { user.notifications.count }.from(0).to(2)
      end
    end

    context "when there's no stale artists" do
      before do
        artist.update_attribute(:updated_at, Time.zone.now)
      end

      it "does nothing" do
        expect { described_class.call }.to_not change { artist.albums.count }
      end
    end
  end
end