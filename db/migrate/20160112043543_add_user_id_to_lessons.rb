class AddUserIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :user_id, :integer
    remove_column :results, :user_id
  end
end
