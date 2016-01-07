class ChangeColumnCorrectAnswerId < ActiveRecord::Migration
  def change
    remove_column :answers, :correct_answer_id, :integer
    add_column :answers, :correct_answer, :boolean
  end
end
