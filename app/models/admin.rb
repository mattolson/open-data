class Admin < ActiveRecord::Base
  # Include desired devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable, :validatable

  # Setup accessible attributes
  attr_accessible :email, :password, :password_confirmation
end
