class AddDisabledAtToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :disabled_at, :datetime, null: true
    add_index :artists, :disabled_at
  end
end
