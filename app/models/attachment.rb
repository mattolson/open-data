class Attachment < ActiveRecord::Base
  # Associations
  belongs_to :dataset

  # Paperclip functionality
  has_attached_file :attachment, :storage => :s3, :s3_credentials => 'config/s3_credentials.yml', :path => 'datasets/:id/:filename'
  
  # Validations
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 50.megabytes
  validates_attachment_content_type :attachment, :content_type => [/^text\/.*$/, 'application/pdf', 'application/vnd.ms-excel', 'application/vnd.google-earth.kml+xml', 'application/vnd.google-earth.kmz'], :message => 'is not an approved type'
end
