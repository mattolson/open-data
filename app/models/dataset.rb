class Dataset < ActiveRecord::Base
  has_and_belongs_to_many :apps
  
end
