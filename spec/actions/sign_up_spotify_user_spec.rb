# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SignUpSpotifyUser do
  subject(:sign_up_spotify_user) { described_class.new(omniauth_data) }

  let(:omniauth_data) { instance_double('OpenStruct') }

  describe '#call' do
    let(:user) { instance_double('User') }

    before do
      allow(User)
        .to receive(:find_or_create_from_omniauth)
        .with(omniauth_data)
        .and_return(user)
    end

    context "when user can't be persisted" do
      before { allow(user).to receive(:persisted?).and_return(false) }

      it 'returns an unsuccessful result' do
        result = sign_up_spotify_user.call

        expect(result.success?).to be(false)
        expect(result.user).to eql(user)
      end
    end

    context 'when user is persisted' do
      before do
        allow(user).to receive(:persisted?).and_return(true)
        allow(user).to receive(:artists).and_return([1])
      end

      it 'returns a successful result' do
        result = sign_up_spotify_user.call

        expect(result.success?).to be(true)
        expect(result.user).to eql(user)
      end

      context "when user isn't following any artist" do
        before do
          allow(user).to receive(:artists).and_return([])
          allow(FetchNewUserArtistsJob).to receive(:perform_later)
        end

        it 'enqueues a new FetchNewUserArtistsJob' do
          sign_up_spotify_user.call

          expect(FetchNewUserArtistsJob)
            .to have_received(:perform_later)
            .with(user)
        end
      end
    end
  end
end
