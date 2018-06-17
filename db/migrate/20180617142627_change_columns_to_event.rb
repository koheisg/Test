class ChangeColumnsToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :pcode, :string
    add_column :events, :lcode, :string
    add_column :events, :ycode, :string
  end
end
