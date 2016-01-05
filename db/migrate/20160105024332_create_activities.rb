class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :activities
      t.timestamps null: false
    end
    add_index :activities, [:user_id, :created_at]
  end
end
