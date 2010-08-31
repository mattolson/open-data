class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :title, :null => false
      t.text :description
      t.string :submitter_name, :null => false
      t.string :submitter_email, :null => false
      t.string :author_link
      t.string :application_link, :null => false
      t.string :screenshot_filename
      t.datetime :submitted_at, :null => false
      t.datetime :published_at
      t.boolean :is_featured, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
