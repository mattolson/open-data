class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name, :null => false
      t.text :description
      t.string :link
      t.string :submitter_name, :null => false
      t.string :submitter_email, :null => false
      t.string :logo_filename
      t.datetime :submitted_at, :null => false
      t.datetime :published_at
      t.boolean :is_partner, :null => false, :default => false
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
