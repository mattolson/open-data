class CreatePressItems < ActiveRecord::Migration
  def self.up
    create_table :press_items do |t|
      t.string :title, :null => false
      t.text :blurb
      t.string :link
      t.datetime :published_at, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :press_items
  end
end
