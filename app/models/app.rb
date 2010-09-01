class App < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :datasets

  # Validation
  validates :title, :presence => true
end
