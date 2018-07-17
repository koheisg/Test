class RenameGeininFollowingsToFollowings < ActiveRecord::Migration[5.1]
  def change
    rename_table :geinin_followings, :followings
  end
end
