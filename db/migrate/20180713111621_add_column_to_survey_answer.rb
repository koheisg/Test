class AddColumnToSurveyAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :survey_answers, :survey, foreign_key: true
  end
end
