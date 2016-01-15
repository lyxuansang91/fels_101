5.times do |n|
  name = t("basic") + "#{n+1}"
  des = t "study_with_me"
  Category.create(name: name, description: des)
end

categories = Category.all
categories.each do |category|
  20.times do |n|
    name = Faker::Lorem.word
    Word.create(name: name, category_id: category.id)
  end
end

Word.all.each do |n|
  k = Random.rand(3) + 1
  4.times do |t|
    content = Faker::Lorem.word
    correct = t == k
    Answer.create(name: content, correct_answer: correct, word_id: n.id)
  end
end
