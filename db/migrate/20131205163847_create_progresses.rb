class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.text :content

      t.timestamps
    end
    add_index :progresses, :user_id
    add_index :progresses, :lesson_id
    add_index :progresses, [:user_id, :lesson_id], unique: true
  end
end
