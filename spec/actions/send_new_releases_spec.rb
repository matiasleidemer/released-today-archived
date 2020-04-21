# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendNewReleases do
  include ActiveJob::TestHelper

  def mailer_jobs_count
    enqueued_jobs.count { |item| item[:job] == ActionMailer::DeliveryJob }
  end

  subject(:send_new_releases) { described_class.call(Notification.pending) }

  let(:user) { FactoryBot.create(:user, preferences: { email_frequency: 'daily' }) }
  let(:artist) { FactoryBot.create(:artist) }
  let(:album) { FactoryBot.create(:album, artist: artist) }

  before do
    Notification.create(user: user, album: album)
  end

  describe '.call' do
    it 'sends the pending releases to users' do
      expect { send_new_releases }.to change { mailer_jobs_count }.from(0).to(1)
    end

    it 'marks the notifications as sent' do
      expect { send_new_releases }.to change { Notification.pending.count }.from(1).to(0)
    end

    context 'when user does not want to receive notifications right away' do
      let(:user) { FactoryBot.create(:user, preferences: { email_frequency: nil }) }

      it 'does not send the pending releases to users' do
        expect { send_new_releases }.not_to change { mailer_jobs_count }.from(0)
      end

      it 'does not mark the notifications as sent' do
        expect { send_new_releases }.not_to change { Notification.pending.count }.from(1)
      end
    end
  end
end
