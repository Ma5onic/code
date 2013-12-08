class RemoveLessonOrderFormLessons < ActiveRecord::Migration
  def change
  	remove_column :lessons, :lesson_order
  end
end
