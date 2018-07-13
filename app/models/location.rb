class Location < ActiveRecord::Base
  
  has_many :edibles
  belongs_to :user
end
