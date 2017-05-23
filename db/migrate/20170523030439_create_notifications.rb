class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :album, foreign_key: true
      t.datetime :sent_at

      t.timestamps
    end
  end
end
