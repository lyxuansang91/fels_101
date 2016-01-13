class LessonsController < ApplicationController
  before_action :signed_in_user, only: [:index, :show]
  before_action :find_lesson, except: [:index, :destroy]
  before_action :create_lesson, only: [:index]

  def index
    if @transaction_success
      flash[:success] = t "lesson.create_success"
      redirect_to @lesson
    else
      flash[:danger] = t "lesson.can_not_save_words"
      redirect_to root_url
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.submit_success"
    else
      flash[:notice] = t "lesson.update_fail"
    end
    redirect_to root_url
  end

  private
  def create_lesson
    @category = Category.find params[:category_id]
    name = "#{@category.name}_#{(Time.now.to_f * 1000).to_i}"
    @lesson = Lesson.new category_id: @category.id, user_id: @current_user.id, name: name
    @transaction_success = true
    Lesson.transaction do
      begin
        @lesson.save!
        words = Word.generate_words_in_lessons @category.id
        raise t "error" unless Word.save_words_in_result @lesson.id, words
      rescue
        @transaction_success = false
        raise ActiveRecord::Rollback
      end
    end
  end

  def find_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.required(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end
end
