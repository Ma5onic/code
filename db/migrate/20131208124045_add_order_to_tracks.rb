class AddOrderToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :order, :integer
  end
end
