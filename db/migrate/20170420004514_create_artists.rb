class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :spotify_id, null: false
      t.json :metadata
    end

    add_index :artists, :spotify_id
  end
end
