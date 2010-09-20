class AddDatasetScreenshot < ActiveRecord::Migration
  def self.up
    add_column :datasets, :screenshot_file_name, :string
    add_column :datasets, :screenshot_content_type, :string
    add_column :datasets, :screenshot_file_size, :integer
    add_column :datasets, :screenshot_updated_at, :datetime
  end

  def self.down
    remove_column :datasets, :screenshot_file_name
    remove_column :datasets, :screenshot_content_type
    remove_column :datasets, :screenshot_file_size
    remove_column :datasets, :screenshot_updated_at
  end
end
