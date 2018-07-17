class Survey < ApplicationRecord
  has_many :survey_answers, dependent: :destroy
  accepts_nested_attributes_for :survey_answers, allow_destroy: true,reject_if: :all_blank

  scope :default, -> { includes(:survey_answers)
                      .references(:survey_answers)}
end