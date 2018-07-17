class AddColumnsToSurveyAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :survey_answers, :votes, :integer
  end
end
