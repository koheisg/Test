class AddColumnToSurvey < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :start, :date
    add_column :surveys, :end, :date
  end
end
