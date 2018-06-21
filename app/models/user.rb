class User < ActiveRecord::Base
  has_secure_password
  has_many :locations, through: :edibles
  has_many :edibles, through: :locations

    validates :username, uniqueness: { case_sensitive: false }
 end