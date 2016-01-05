class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :word_id
      t.string :name
      t.integer :correct_answer_id

      t.timestamps null: false
    end
  end
end
