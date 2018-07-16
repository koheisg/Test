class ChangeColumntGeininMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column :geinin_members, :instagra_id, :instagram_id
  end
end
