class CreateGeininTags < ActiveRecord::Migration[5.1]
  def change
    create_table :geinin_tags do |t|
      t.references :geinin_id
      t.string :tag

      t.timestamps
    end
  end
end
