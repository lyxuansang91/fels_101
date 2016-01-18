class RenameFirstContentSecondContentFromActivities < ActiveRecord::Migration
  def change
    rename_column :activities, :first_content, :user_name
    rename_column :activities, :second_content, :target
  end
end
