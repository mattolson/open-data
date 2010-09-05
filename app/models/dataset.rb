class Dataset < ActiveRecord::Base
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_and_belongs_to_many :apps
end
