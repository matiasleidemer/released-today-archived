# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '.mark_as_sent' do
    let(:notification) { instance_double('Notification') }

    before do
      Timecop.freeze(Time.zone.now)
      allow(notification).to receive(:update_attribute)
    end

    after { Timecop.return }

    it 'updates the provided notifications sent_at attribute with the current time' do
      described_class.mark_as_sent([notification])

      expect(notification)
        .to have_received(:update_attribute)
        .with(:sent_at, Time.zone.now)
    end
  end
end
