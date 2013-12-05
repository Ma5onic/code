class AddCourseCreatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :course_creator, :boolean, default: false
  end
end
