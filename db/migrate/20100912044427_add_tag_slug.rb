class AddTagSlug < ActiveRecord::Migration
  def self.up
    add_column :tags, :slug, :string
  end

  def self.down
    remove_column :tags, :slug
  end
end
