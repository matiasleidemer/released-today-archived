require 'rails_helper'

RSpec.describe SignUpSpotifyUser do
  let(:omniauth_data)   { double(:omniauth_data) }
  let(:user_repository) { double(:repo) }

  subject { described_class.new(omniauth_data, user_repository: user_repository) }

  describe '#call' do
    let(:user) { double(:user) }

    before do
      allow(user_repository)
        .to receive(:find_or_create_from_omniauth)
        .with(omniauth_data)
        .and_return(user)
    end

    context "when user can't be persisted" do
      before { allow(user).to receive(:persisted?).and_return(false) }

      it "returns an unsuccessful result" do
        result = subject.call

        expect(result.success?).to eql(false)
        expect(result.user).to eql(user)
      end
    end

    context "when user is persisted" do
      before do
        allow(user).to receive(:persisted?).and_return(true)
        allow(user).to receive(:artists).and_return([1])
      end

      it "returns a successful result" do
        result = subject.call

        expect(result.success?).to eql(true)
        expect(result.user).to eql(user)
      end

      context "when user isn't following any artist" do
        before { allow(user).to receive(:artists).and_return([]) }

        it "enqueues a new FetchNewUserArtistsJob" do
          expect(FetchNewUserArtistsJob).to receive(:perform_later).with(user)
          subject.call
        end
      end
    end
  end
end
