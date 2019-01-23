require 'rails_helper'

RSpec.describe User do
  describe '.find_or_create_from_omniauth' do
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

    subject { described_class.find_or_create_from_omniauth(auth) }

    it "creates a new user with the omniath data" do
      expect(subject).to have_attributes({
        uid: '112233',
        provider: 'spotify',
        name: 'John Snow',
        email: 'johnsnow@gmail.com',
        email_frequency: 'daily',
        metadata: auth.to_json
      })
    end

    context 'when the user already exists' do
      let!(:user) { FactoryGirl.create(:user, uid: 42, provider: 'spotify') }
      let(:auth) { OpenStruct.new({ provider: 'spotify', uid: 42 }) }

      it "returns the with the provider and uid" do
        expect(subject).to eql(user)
      end
    end
  end
end
