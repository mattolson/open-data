class DropPublishedAt < ActiveRecord::Migration
  def self.up
    remove_column :datasets, :published_at
  end

  def self.down
    add_column :datasets, :published_at, :datetime, :null => false
  end
end
