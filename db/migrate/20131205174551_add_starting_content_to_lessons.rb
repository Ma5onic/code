class AddStartingContentToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :starting_content, :text
  end
end
