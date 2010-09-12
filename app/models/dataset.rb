class Dataset < ActiveRecord::Base
  # Constants
  MAX_ATTACHMENTS = 5

  # Associations
  has_many :attachments, :class_name => '::Attachment', :dependent => :destroy # class_name to avoid collision with Paperclip
  has_and_belongs_to_many :apps
  
  # Tagging
  acts_as_taggable_on :tags, :certifications, :standards
  
  # Validations
  validates_presence_of :title, :description
  validates_length_of :title, :maximum => 256
  validates_length_of :description, :maximum => 10.kilobytes
  validates_date :start_date, :allow_blank => true
  validates_date :end_date, :allow_blank => true
  validates_inclusion_of :category, :in => Configs.select_lists['dataset_categories'].values.keys, :if => :category
  
  # Set attributes available for mass-assignment
  attr_accessible :title, :description, :start_date, :end_date, :is_featured, :attachments_attributes, :category, :tag_list, :standard_list, :certification_list
  accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank
  
  # Hooks
  before_save :update_uploaded_at
  
  def update_uploaded_at
    return unless self.attachments.loaded?
    if self.attachments.any? { |a| a.new_record? }
      self.last_uploaded_at = DateTime.now
    end
  end
end
