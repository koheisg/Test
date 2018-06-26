class CreateGeininFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :geinin_followings do |t|
      t.references :user_id, foreign_key: true
      t.references :geinin_if, foreign_key: true

      t.timestamps
    end
  end
end
