class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.integer :word_id
      t.integer :answer_id

      t.timestamps null: false
    end
    add_index :results, [:user_id, :lesson_id, :created_at]
  end
end
