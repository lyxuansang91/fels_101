class ResultsController < ApplicationController
  before_action :signed_in_user, only: [:show]
  before_action :load_lesson

  def index
    @results = Result.by_lesson @lesson.id
  end

  private
  def load_lesson
    @lesson = Lesson.find params[:lesson_id]
  end
end
