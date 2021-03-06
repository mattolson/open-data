class Admin < ActiveRecord::Base
  # Include desired devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable, :validatable

  # Set attributes available for mass-assignment
  attr_accessible :email, :password, :remember_me
end
