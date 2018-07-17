class Edible < ActiveRecord::Base
  
  has_many :locations, through: :users

  
end