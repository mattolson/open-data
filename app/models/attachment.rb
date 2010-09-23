class Attachment < ActiveRecord::Base
  # Associations
  belongs_to :dataset, :touch => :last_uploaded_at

  # Paperclip functionality
  has_attached_file :attachment,
                    :storage        => :s3,
                    :path           => "#{ ENV['RAILS_ENV'] }/datasets/attachments/:id/:filename",
                    :s3_headers     => {'Content-Disposition' => 'attachment'},
                    :bucket         => ENV['S3_BUCKET'],
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'],
                                         :secret_access_key => ENV['S3_SECRET'] }
  # Validations
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 50.megabytes
  validates_attachment_content_type :attachment, :content_type => [/^text\/.*$/, 'application/pdf', 'application/vnd.ms-excel', 'application/vnd.google-earth.kml+xml', 'application/vnd.google-earth.kmz'], :message => 'is not an approved type'
end
