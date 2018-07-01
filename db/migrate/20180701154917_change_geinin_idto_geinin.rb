class ChangeGeininIdtoGeinin < ActiveRecord::Migration[5.1]
  def change
    remove_column :geinin_members, :geinin_id_id, :references
    remove_column :geinin_member_tags, :geinin_id_id, :references
    remove_column :geinin_tags, :geinin_id_id, :references
    remove_column :geinin_followings, :geinin_id_id, :references
    remove_column :geinin_followings, :user_id_id, :references      
    add_reference :geinin_members, :geinin, foreign_key: true
    add_reference :geinin_member_tags, :geinin, foreign_key: true   
    add_reference :geinin_tags, :geinin, foreign_key: true   
    add_reference :geinin_followings, :geinin, foreign_key: true
    add_reference :geinin_followings, :user, foreign_key: true
  end
end
