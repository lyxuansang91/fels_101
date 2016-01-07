class Word < ActiveRecord::Base

  belongs_to :category
  has_many :answers
  scope :by_category, ->(category_id){where category_id: category_id}
  scope :learned, ->(user_id){where Settings.word.LEARNED_WORDS_QUERY, user_id: user_id}
  scope :unlearned, ->(user_id){where.not Settings.word.LEARNED_WORDS_QUERY, user_id: user_id}

  class << self
    def all_status
      [I18n.t("word.all"), I18n.t("word.learned"), I18n.t("word.not_learned")]
    end

    def filter_by_category user_id, category_id, status
      case status
      when Settings.word.ALL_WORDS
        Word.by_category category_id
      when Settings.word.LEARN_WORDS
        Word.by_category(category_id).learned user_id
      else
        Word.by_category(category_id).unlearned user_id
      end
    end
  end

  def right_answer
    answers.find_by correct_answer: true
  end
end
