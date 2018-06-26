class CreateGeinins < ActiveRecord::Migration[5.1]
  def change
    create_table :geinins do |t|
      t.string :name
      t.string :yomi
      t.string :production
      t.integer :start_year
      t.string :twitter_id
      t.string :instagram_id
      t.string :youtube_url
      t.string :facebook_url
      t.string :blog_url
      t.string :official_profile_url
      t.date :end_date

      t.timestamps
    end
  end
end
