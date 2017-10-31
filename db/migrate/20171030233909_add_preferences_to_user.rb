class AddPreferencesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :preferences, :jsonb, null: false, default: '{}'
    add_index  :users, :preferences, using: :gin
  end
end
