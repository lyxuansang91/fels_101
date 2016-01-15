class Word < ActiveRecord::Base

  belongs_to :category
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  scope :by_category, ->(category_id){where category_id: category_id}
  scope :learned, ->(user_id){where Settings.word.LEARNED_WORDS_QUERY, user_id:
    user_id}
  scope :unlearned, ->(user_id){where.not Settings.word.LEARNED_WORDS_QUERY,
    user_id: user_id}

  class << self
    def all_status
      [I18n.t("word.all"), I18n.t("word.learned"), I18n.t("word.not_learned")]
    end

    def generate_words_in_lessons category_id
      Word.by_category(category_id).shuffle[0..Settings.word.LESSON_SIZE]
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

    def save_words_in_result lesson_id, words
      Result.transaction(requires_new: true) do
        begin
          words.each do |word|
            new_result = Result.new lesson_id: lesson_id, word_id: word.id
            new_result.save!
          end
        rescue
          raise ActiveRecord::Rollback
        end
      end
    end
  end

  def right_answer
    answers.find_by correct_answer: true
  end
end
