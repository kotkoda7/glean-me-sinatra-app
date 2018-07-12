class Location < ActiveRecord::Base
  

  belongs_to :edible
  belongs_to :user
end
