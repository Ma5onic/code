class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :content
      t.text :task
      t.text :hints
      t.integer :track_id
      t.string :permalink

      t.timestamps
    end
  end
end
