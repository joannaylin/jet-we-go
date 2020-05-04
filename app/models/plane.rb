class Plane < ApplicationRecord
  has_many :rentals
  has_many :users, through: :rentals
  has_many :airports, through: :rentals

  def is_available
    if self.available
      "Yes"
    else
      "No"
    end 
  end
  
  def self.planes_available
    self.all.filter {|plane| plane.available == true}
  end

end
