# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowArtists do
  subject(:follow_artists) do
    described_class.call(user: user, artists: [dinosaur_jr, descendents])
  end

  let(:user) { create(:user) }
  let(:dinosaur_jr) { Spotify::Artist.new({ id: '1', name: 'Dinosaur Jr.', type: 'artist' }) }
  let(:descendents) { Spotify::Artist.new({ id: '2', name: 'Descendents', type: 'artist' }) }

  describe '#call' do
    it 'creates the artists' do
      expect { follow_artists }.to change(Artist, :count).from(0).to(2)
    end

    it 'makes the user follow the artists' do
      expect { follow_artists }.to change { user.artists.count }.from(0).to(2)
    end
  end
end
