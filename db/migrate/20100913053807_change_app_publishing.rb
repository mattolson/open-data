class ChangeAppPublishing < ActiveRecord::Migration
  def self.up
    remove_column :apps, :published_at
    add_column :apps, :is_published, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :apps, :is_published
    add_column :apps, :published_at, :datetime
  end
end
