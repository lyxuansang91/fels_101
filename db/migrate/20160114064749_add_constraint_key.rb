class AddConstraintKey < ActiveRecord::Migration
  def change
    add_foreign_key :lessons, :categories
    add_foreign_key :lessons, :users
    add_foreign_key :results, :words
    add_foreign_key :results, :answers
    add_foreign_key :activities, :users
    add_foreign_key :words, :categories
    add_foreign_key :results, :lessons
  end
end
