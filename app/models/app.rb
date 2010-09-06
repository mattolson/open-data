class App < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :datasets

  # Validation
  validates_presence_of :title
end
