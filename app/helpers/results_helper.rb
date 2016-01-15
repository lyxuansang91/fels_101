module ResultsHelper
  def get_icon answer
    answer.correct_answer? ? "ok": "remove"
  end

  def get_info lesson
    "#{lesson.name}, point #{lesson.number_correct_answer}/#{lesson.results.count}"
  end
end
