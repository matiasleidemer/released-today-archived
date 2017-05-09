require "rails_helper"

RSpec.describe Artist do
  describe "#image_url" do
    let(:artist) { Artist.new(metadata: { "images" => [{ "url" => "image_path" }] }) }

    it "returns the artist's image url" do
      expect(artist.image_url).to eql("image_path")
    end

    context "images metadata is empty" do
      let(:artist) { Artist.new(metadata: { "images" => [] }) }

      it "returns nil" do
        expect(artist.image_url).to be_nil
      end
    end
  end
end
