class Dataset < ActiveRecord::Base
  has_many :dataset_files, :dependent => :destroy
  has_and_belongs_to_many :applications
end
