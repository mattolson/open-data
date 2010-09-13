class DropSubmittedAt < ActiveRecord::Migration
  def self.up
    remove_column :apps, :submitted_at
  end

  def self.down
    add_column :apps, :submitted_at, :datetime
  end
end
