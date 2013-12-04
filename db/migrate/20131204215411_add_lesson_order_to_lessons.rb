class AddLessonOrderToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :lesson_order, :string
  end
end
