require 'rails_helper'

RSpec.describe SendNewReleases do
  let(:user) { FactoryGirl.create(:user, preferences: { email_frequency: 'daily' }) }
  let(:artist) { FactoryGirl.create(:artist) }
  let(:album) { FactoryGirl.create(:album, artist: artist) }

  before do
    Notification.create(user: user, album: album)
  end

  subject { described_class.call(Notification.pending) }

  describe '.call' do
    it 'sends the pending releases to users', pending: true do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'marks the notifications as sent' do
      expect { subject }.to change { Notification.pending.count }.from(1).to(0)
    end

    context 'when user does not want to receive notifications right away' do
      let(:user) { FactoryGirl.create(:user, preferences: { email_frequency: nil }) }

      it 'does not send the pending releases to users' do
        expect { subject }.to_not change { ActionMailer::Base.deliveries.count }
      end

      it 'does not mark the notifications as sent' do
        expect { subject }.to_not change { Notification.pending.count }
      end
    end
  end
end
