# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spotify::ReleasesSyncer do
  let(:artist) { create(:artist) }
  let(:user)   { create(:user) }

  before do
    # Only one album from the mock http call returns this date as its
    # "release date". Instead of stubbing any instance of Album, we're
    # mocking the current date, meaning one of the albums will be released
    # today hence change the notification count from 0 to 1
    Timecop.freeze(Time.zone.parse('2016-08-05'))

    artist.users << user
    artist.update_attribute(:updated_at, Time.zone.now - 2.days)
  end

  after do
    Timecop.return
  end

  describe '.call' do
    it "saves the artist's latest releases" do
      VCR.use_cassette 'releases_syncer' do
        expect { described_class.call }
          .to change { artist.albums.count }.from(0).to(2)
      end
    end

    it 'creates new release notifications for users that follow the artist' do
      VCR.use_cassette 'releases_syncer' do
        expect { described_class.call }
          .to change { user.notifications.count }.from(0).to(1)
      end
    end

    context "when there's no stale artists" do
      before do
        artist.update_attribute(:updated_at, Time.zone.now)
      end

      it 'does nothing' do
        expect { described_class.call }
          .not_to change { artist.albums.count }
          .from(0)
      end
    end
  end
end
