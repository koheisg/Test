class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :live_date
      t.time :live_start
      t.string :title
      t.string :description
      t.string :tel

      t.timestamps
    end
  end
end
