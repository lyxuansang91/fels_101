class AddContentToActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :activities
    add_column :activities, :type_content, :integer
    add_column :activities, :first_content, :string
    add_column :activities, :second_content, :string
  end
end
