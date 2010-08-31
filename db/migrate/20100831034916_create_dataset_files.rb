class CreateDatasetFiles < ActiveRecord::Migration
  def self.up
    create_table :dataset_files do |t|
      t.integer :dataset_id, :null => false
      t.string :filename, :null => false
      t.string :mime_type, :null => false
      t.integer :size, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :dataset_files
  end
end
