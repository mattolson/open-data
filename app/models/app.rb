class App < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :datasets

  # Paperclip functionality
  has_attached_file :screenshot,
                    :styles         => { :thumb => ["100x100>", :png] },
                    :convert_options => { :thumb => "-background transparent -gravity center -extent 100x100" },
                    :storage        => :s3,
                    :path           => "#{ ENV['RAILS_ENV'] }/apps/:id/:style_:filename",
                    :bucket         => Configs.s3_bucket,
                    :s3_credentials => { :access_key_id     => Configs.s3_key,
                                         :secret_access_key => Configs.s3_secret }

  # Validation
  validates_presence_of :title, :description, :submitter_name, :datasets
  validates_format_of :submitter_email, :with => ARValidation::EMAIL_RE
  validates_format_of :application_link, :with => ARValidation::URI_RE
  validates_format_of :author_link, :with => ARValidation::URI_RE, :allow_blank => true
  validates_attachment_presence :screenshot
  validates_attachment_size :screenshot, :less_than => 1.megabytes
  validates_attachment_content_type :screenshot, :content_type => [/^image\/.*$/], :message => 'is not an image'
  
  # Set attributes available for mass-assignment
  attr_accessible :title, :description, :submitter_name, :submitter_email, :application_link, :author_link, :screenshot, :dataset_ids, :is_featured, :is_published
end
