class SurveyController < ApplicationController
  def index
    @surveys = Survey.default.all
  end
end
