class FixAppsDatasets < ActiveRecord::Migration
  def self.up
    remove_column :apps_datasets, :id
  end

  def self.down
    add_column :apps_datasets, :id, :integer
  end
end
