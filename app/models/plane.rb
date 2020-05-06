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

  def daily_cost_display
    "$" + "#{daily_cost}"
  end

  def self.newest_plane
    self.order(year_made: :desc).limit(1)
  end

  def self.most_affordable
    self.order(daily_cost: :asc).limit(1)
  end

end
