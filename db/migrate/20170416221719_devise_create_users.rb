class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.json :metadata
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
