class Admin::WordsController < ApplicationController
  before_action :authenticate_admin
  before_action :load_category
  before_action :load_word, only: [:edit, :update, :destroy]

  def index
    @answers_col = Settings.answers
    @words = @category.words.paginate page: params[:page], per_page: Settings.word.per_page
  end

  def new
    @word = Word.new
    Settings.answer.number_answers_of_word.times {@word.answers.build}
  end

  def create
    @word = @category.words.build word_params
    if @word.save
      flash[:success] = t "word.create_success"
      redirect_to [:admin, :category, :words]
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    if @word.destroy
      flash[:success] = t "word.delete_success"
    else
      flash[:danger] = t "word.delete_error"
    end
    redirect_to [:admin, :category, :words]
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "word.update_success"
      redirect_to [:admin, :category, :words]
    else
      flash[:danger] = t "word.update.error"
      render :edit
    end
  end

  private
  def load_category
    @category = Category.find params[:category_id]
  end

  def word_params
    params.require(:word).permit :name, answers_attributes: [:id, :name,
      :correct_answer, :_destroy]
  end

  def load_word
    @word = Word.find params[:id]
  end
end
