class CreateDatasets < ActiveRecord::Migration
  def self.up
    create_table :datasets do |t|
      t.string :title, :null => false
      t.text :description
      t.datetime :published_at, :null => false
      t.datetime :last_uploaded_at
      t.boolean :is_featured, :null => false, :default => false
      t.date :start_date
      t.date :end_date
      t.integer :download_count, :null => false, :default => 0
      t.timestamps
    end

    create_table :datasets_apps do |t|
      t.integer :dataset_id, :null => false
      t.integer :app_id, :null => false
    end
  end

  def self.down
    drop_table :datasets
    drop_table :datasets_apps
  end
end
