class RenameKarmaToPointsInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :karma, :points
  end
end
