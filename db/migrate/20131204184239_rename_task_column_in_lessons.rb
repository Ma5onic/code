class RenameTaskColumnInLessons < ActiveRecord::Migration
  def change
  	rename_column :lessons, :task, :instructions
  end
end
