class RemoveFileInfoFromDataset < ActiveRecord::Migration
  def self.up
    remove_column :datasets, :file_name
    remove_column :datasets, :file_size
    remove_column :datasets, :mime_type
    remove_column :companies, :logo_filename
    remove_column :apps, :screenshot_filename
  end

  def self.down
    add_column :datasets, :file_name
    add_column :datasets, :file_size
    add_column :datasets, :mime_type
    add_column :companies, :logo_filename
    add_column :apps, :screenshot_filename
  end
end
