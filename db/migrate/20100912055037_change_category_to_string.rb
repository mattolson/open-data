class ChangeCategoryToString < ActiveRecord::Migration
  def self.up
    change_column :datasets, :category, :string
  end

  def self.down
    change_column :datasets, :category, :integer
  end
end
