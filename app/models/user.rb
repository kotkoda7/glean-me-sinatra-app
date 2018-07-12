class User < ActiveRecord::Base
  has_secure_password
  has_many :locations
  has_many :edibles, through: :locations

  validates :username, presence: true, uniqueness: true
end
