class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :category_id
      t.string :word
      t.string :answer
      t.timestamps null: false
    end
    add_index :lessons, [:category_id, :created_at]
  end
end
