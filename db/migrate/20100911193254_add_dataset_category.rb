class AddDatasetCategory < ActiveRecord::Migration
  def self.up
    add_column :datasets, :category, :integer
  end

  def self.down
    remove_column :datasets, :category
  end
end
