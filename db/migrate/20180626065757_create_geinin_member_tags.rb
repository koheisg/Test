class CreateGeininMemberTags < ActiveRecord::Migration[5.1]
  def change
    create_table :geinin_member_tags do |t|
      t.references :geinin_id
      t.references :geinin_member_id
      t.string :tag

      t.timestamps
    end
  end
end
