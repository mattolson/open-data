class RemovePressBlurb < ActiveRecord::Migration
  def self.up
    remove_column :press_items, :blurb
    add_column :press_items, :source, :string
  end

  def self.down
    add_column :press_items, :blurb, :text
    remove_column :press_items, :source
  end
end
