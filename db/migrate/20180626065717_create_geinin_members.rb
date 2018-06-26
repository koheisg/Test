class CreateGeininMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :geinin_members do |t|
      t.references :geinin_id
      t.string :name
      t.string :yomi
      t.string :twitter_id
      t.string :instagra_id
      t.string :blog_url

      t.timestamps
    end
  end
end
