require 'rails_helper'
require 'released/jwt'

RSpec.describe Released::Jwt do
  subject { described_class.new(global_token: global_token) }

  let(:global_token) { '1234' }
  let(:payload) { { this: 'payload' } }

  let(:encoded_payload) do
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.'\
    'eyJ0aGlzIjoicGF5bG9hZCJ9.'\
    '27AzP7zfJOsl0n-IbUg8Y4d0N-omeclPJaA9-jRVFKU'
  end

  describe '#encode' do
    it 'encodes the given payload using JWT' do
      expect(subject.encode(payload)).to eql(encoded_payload)
    end
  end

  describe '#decode' do
    it 'decodes the given payload using JWT' do
      decoded = subject.decode(encoded_payload)
      expect(decoded.first).to eql("this" => "payload")
    end
  end
end
