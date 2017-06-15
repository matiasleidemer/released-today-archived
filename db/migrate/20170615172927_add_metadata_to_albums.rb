class AddMetadataToAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :metadata, :json
  end
end
