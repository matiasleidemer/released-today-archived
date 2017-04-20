class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.references :artist, null: false
      t.string :spotify_id, null: false
      t.string :name, null: false
      t.string :image_url, null: false
      t.integer :number_of_tracks, null: false
      t.date :released_at, null: false
      t.timestamps
    end

    add_foreign_key :albums, :artists
    add_index :albums, :spotify_id
  end
end
