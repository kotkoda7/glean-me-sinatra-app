class Edible < ActiveRecord::Base
  
  has_many :locations
end