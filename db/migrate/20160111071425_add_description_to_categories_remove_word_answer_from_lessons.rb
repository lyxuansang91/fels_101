class AddDescriptionToCategoriesRemoveWordAnswerFromLessons < ActiveRecord::Migration
  def change
    add_column :categories, :description, :string
    remove_column :lessons, :word
    remove_column :lessons, :answer
  end
end
