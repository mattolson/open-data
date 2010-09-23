class PressItem < ActiveRecord::Base
  # Validation
  validates_presence_of :title, :source, :link, :published_at
  validates_format_of :link, :with => ARValidation::URI_RE
  validates_date :published_at

  # Set attributes available for mass-assignment
  attr_accessible :title, :source, :link, :published_at
end
