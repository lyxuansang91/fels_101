class WordsController < ApplicationController
  before_action :signed_in_user, only: [:index]
  before_action :load_data

  def index
    @words_by_filter = params[:button].nil? ? Word.all :
      Word.filter_by_category(@current_user.id, @category, @status)
    @words = @words_by_filter.paginate page: params[:page], per_page:
      Settings.word.per_page
  end

  private
  def load_data
    @word_statuses = Word.all_status
    @categories = Category.all
    @status = params[:status].nil? ? @word_statuses[0] : params[:status].to_i
    @category = params[:category].to_i
  end
end
