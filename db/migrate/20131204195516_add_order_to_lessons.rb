class AddOrderToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :order, :integer
  end
end
