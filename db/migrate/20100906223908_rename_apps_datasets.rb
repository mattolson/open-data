class RenameAppsDatasets < ActiveRecord::Migration
  def self.up
    rename_table :datasets_apps, :apps_datasets
  end

  def self.down
    rename_table :apps_datasets, :datasets_apps
  end
end
