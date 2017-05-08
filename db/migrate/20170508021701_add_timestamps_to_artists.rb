class AddTimestampsToArtists < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :artists
  end
end
