class CreateArtistsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :artists_users do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :user, index: true
    end

    add_foreign_key :artists_users, :artists
    add_foreign_key :artists_users, :users
  end
end
