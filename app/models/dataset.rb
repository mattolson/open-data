class Dataset < ActiveRecord::Base
  # Constants
  MAX_ATTACHMENTS = 5

  # Associations
  has_many :attachments, :class_name => '::Attachment', :as => :attachable, :dependent => :destroy # class_name to avoid collision with Paperclip
  has_and_belongs_to_many :apps
  
  # Tagging
  acts_as_taggable
  acts_as_taggable_on :categories, :certifications, :standards
  
  # Validations
  validates_presence_of :title, :description
  validates_length_of :title, :maximum => 256
  validates_length_of :description, :maximum => 10.kilobytes
  validates_date :start_date, :allow_blank => true
  validates_date :end_date, :allow_blank => true

  # Set attributes available for mass-assignment
  attr_accessible :title, :description, :start_date, :end_date, :is_featured, :attachments_attributes
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  
end
