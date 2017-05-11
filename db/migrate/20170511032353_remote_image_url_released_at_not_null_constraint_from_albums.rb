class RemoteImageUrlReleasedAtNotNullConstraintFromAlbums < ActiveRecord::Migration[5.0]
  def change
    change_column :albums, :released_at, :date, null: true
    change_column :albums, :image_url, :string, null: true
  end
end
