class RemoveDatasetFiles < ActiveRecord::Migration
  def self.up
    add_column :datasets, :file_name, :string, :null => false
    add_column :datasets, :mime_type, :string, :null => false
    add_column :datasets, :file_size, :integer, :null => false
    
    drop_table :dataset_files
  end

  def self.down
    remove_column :datasets, :file_name
    remove_column :datasets, :mime_type
    remove_column :datasets, :file_size

    create_table :dataset_files do |t|
      t.integer :dataset_id, :null => false
      t.string :filename, :null => false
      t.string :mime_type, :null => false
      t.integer :size, :null => false
      t.timestamps
    end
  end
end
