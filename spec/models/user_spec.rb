# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '.find_or_create_from_omniauth' do
    subject(:omniath_user) { described_class.find_or_create_from_omniauth(auth) }

    let(:auth) do
      OpenStruct.new({
        provider: 'spotify',
        uid: '112233',
        info: OpenStruct.new({
          name: 'John Snow',
          email: 'johnsnow@gmail.com'
        })
      })
    end

    it 'creates a new user with the omniath data' do
      expect(omniath_user).to have_attributes({
        uid: '112233',
        provider: 'spotify',
        name: 'John Snow',
        email: 'johnsnow@gmail.com',
        email_frequency: 'daily',
        metadata: auth.to_json
      })
    end

    context 'when the user already exists' do
      let!(:user) { FactoryBot.create(:user, uid: 42, provider: 'spotify') }
      let(:auth) { OpenStruct.new({ provider: 'spotify', uid: 42 }) }

      it 'returns the with the provider and uid' do
        expect(omniath_user).to eql(user)
      end
    end
  end
end
