class AddCourseIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :course_id, :integer
  end
end
