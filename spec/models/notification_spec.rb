require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '.mark_as_sent' do
    before { Timecop.freeze(Time.zone.now) }
    after { Timecop.return }

    let(:notification) { double(:notification) }

    it 'updates the provided notifications sent_at attribute with the current time' do
      expect(notification)
        .to receive(:update_attribute)
        .with(:sent_at, Time.zone.now)
      described_class.mark_as_sent([notification])
    end
  end
end
