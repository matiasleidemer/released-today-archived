require 'rails_helper'

describe AuthenticateSpotify do
  describe '.call' do
    let(:authenticator) { spy(:authenticator) }
    let(:env) { 'production' }

    before do
      allow(authenticator).to receive(:authenticate)
    end

    it 'calls the authenticator with the provided parameters' do
      AuthenticateSpotify.authenticator = authenticator
      AuthenticateSpotify.call(client_id: '1234', client_secret: '5678', env: env)

      expect(authenticator).to have_received(:authenticate).with('1234', '5678')
    end

    it 'does nothing if env is test' do
      AuthenticateSpotify.authenticator = authenticator
      AuthenticateSpotify.call(client_id: '1234', client_secret: '5678', env: 'test')

      expect(authenticator).to_not have_received(:authenticate)
    end
  end
end
