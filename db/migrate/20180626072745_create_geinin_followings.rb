class CreateGeininFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :geinin_followings do |t|
      t.references :user_id
      t.references :geinin_id

      t.timestamps
    end
  end
end
