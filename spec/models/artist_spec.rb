# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist do
  describe '.create_or_update_from_spotify' do
    subject(:artist) { described_class.create_or_update_from_spotify(payload) }

    let(:payload) do
      {
        spotify_id: '1q2w3e',
        name: 'Descendents',
        metadata: { spotify_id: '1q2w3e', name: 'Descendents' }.to_json
      }
    end

    it "creates a new user using spotify's payload" do
      expect(artist.spotify_id).to eql(payload[:spotify_id])
      expect(artist.name).to eql(payload[:name])
      expect(artist.metadata).to eql(payload[:metadata])
    end
  end

  describe '#image_url' do
    let(:artist) { described_class.new(metadata: { 'images' => [{ 'url' => 'image_path' }] }) }

    it "returns the artist's image url" do
      expect(artist.image_url).to eql('image_path')
    end

    context 'when images metadata is empty' do
      let(:artist) { described_class.new(metadata: { 'images' => [] }) }

      it 'returns nil' do
        expect(artist.image_url).to be_nil
      end
    end
  end
end
