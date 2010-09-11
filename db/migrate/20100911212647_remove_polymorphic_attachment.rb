class RemovePolymorphicAttachment < ActiveRecord::Migration
  def self.up
    Attachment.delete_all
    remove_index :attachments, :index_attachments_on_attachable_id_and_attachable_type
    remove_column :attachments, :attachable_id
    remove_column :attachments, :attachable_type
    add_column :attachments, :dataset_id, :integer, :null => false
    add_index :attachments, :dataset_id
  end

  def self.down
    remove_column :attachments, :dataset_id
    add_column :attachments, :attachable_id, :integer
    add_column :attachments, :attachable_type, :string
    add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"
  end
end
