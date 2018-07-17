class RenameSurveyToSurveyAnswer < ActiveRecord::Migration[5.1]
  def change
    rename_table :surveys, :survey_answers
  end
end
