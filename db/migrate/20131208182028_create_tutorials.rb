class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :name
      t.integer :order
      t.text :content
      t.integer :track_id
      t.string :permalink
      t.string :user_id

      t.timestamps
    end
  end
end
