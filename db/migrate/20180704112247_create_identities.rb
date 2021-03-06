class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
