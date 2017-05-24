require 'rails_helper'

RSpec.describe Album do
  describe '#followers' do
    subject      { create(:album, artist: artist) }
    let(:artist) { create(:artist) }
    let(:user)   { create(:user) }
    let(:user_2) { create(:user) }

    it "returns the album artist's followers" do
      artist.users << user
      expect(subject.followers).to eq([user])
    end
  end
end
