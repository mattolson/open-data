class UpdateCompanies < ActiveRecord::Migration
  def self.up
    remove_column :companies, :description
    remove_column :companies, :submitted_at
    remove_column :companies, :published_at
    add_column :companies, :is_published, :boolean, :default => false, :null => :false
    add_column :companies, :logo_file_name, :string
    add_column :companies, :logo_content_type, :string
    add_column :companies, :logo_file_size, :integer
    add_column :companies, :logo_updated_at, :datetime
  end

  def self.down
    add_column :companies, :description, :text
    add_column :companies, :submitted_at, :datetime
    add_column :companies, :published_at, :datetime
    remove_column :companies, :is_published
    remove_column :companies, :logo_file_name
    remove_column :companies, :logo_content_type
    remove_column :companies, :logo_file_size
    remove_column :companies, :logo_updated_at
  end
end
