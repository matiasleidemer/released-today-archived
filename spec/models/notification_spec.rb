require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '.mark_as_sent' do
    before { Timecop.freeze(Time.zone.now) }
    after { Timecop.return }

    let(:notification) { spy(:notification) }

    it 'updates the provided notifications sent_at attribute with the current time' do
      described_class.mark_as_sent([notification])

      expect(notification)
        .to have_received(:update_attribute)
        .with(:sent_at, Time.zone.now)
    end
  end
end
