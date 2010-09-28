class Dataset < ActiveRecord::Base
  # Constants
  MAX_ATTACHMENTS = 5

  # Associations
  has_many :attachments, :class_name => '::Attachment', :dependent => :destroy # class_name to avoid collision with Paperclip
  has_and_belongs_to_many :apps
  
  # Tagging
  acts_as_taggable_on :tags, :certifications, :standards

  # Paperclip functionality
  has_attached_file :screenshot,
                    :styles         => { :thumb => ["100x100>", :png] },
                    :convert_options => { :thumb => "-background transparent -gravity center -extent 100x100" },
                    :storage        => :s3,
                    :path           => "#{ ENV['RAILS_ENV'] }/datasets/:id/:style_:filename",
                    :bucket         => ENV['S3_BUCKET'],
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'],
                                         :secret_access_key => ENV['S3_SECRET'] }

  # Validations
  validates_presence_of :title, :description
  validates_length_of :title, :maximum => 256
  validates_length_of :description, :maximum => 10.kilobytes
  validates_date :start_date, :allow_blank => true
  validates_date :end_date, :allow_blank => true
  validates_inclusion_of :category, :in => Configs.select_lists['dataset_categories'].values.keys, :if => :category
  validates_attachment_presence :screenshot
  validates_attachment_size :screenshot, :less_than => 1.megabytes
  validates_attachment_content_type :screenshot, :content_type => [/^image\/.*$/], :message => 'is not an image'
  
  # Set attributes available for mass-assignment
  attr_accessible :title, :description, :start_date, :end_date, :is_featured, :attachments_attributes, :category, :tag_list, :standard_list, :certification_list, :screenshot
  accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank
end
