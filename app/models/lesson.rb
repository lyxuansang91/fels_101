class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :words, through: :results, source: "word"
  has_many :answers, through: :results, source: "answer"
  has_many :results, dependent: :destroy
  validate :check_number_of_words, on: :create
  accepts_nested_attributes_for :results
  after_create :add_lesson_activity

  def number_correct_answer
    answers.where(correct_answer: true).count
  end

  private
  def check_number_of_words
    number_of_words = !self.category.nil? ? self.category.words.count : 0
    if number_of_words < Settings.word.LESSON_SIZE
      errors.add :base, I18n.t("lesson.not_enough_word")
    end
  end

  def add_lesson_activity
    activity_content = I18n.t "activity.add_lesson", user_name: user.name, category_name: category.name
    Activity.create! user_id: user.id, activities: activity_content
  end
end
