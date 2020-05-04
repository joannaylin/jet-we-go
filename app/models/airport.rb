class Airport < ApplicationRecord
  belongs_to :city
  has_many :rentals
  has_many :planes, through: :rentals
  has_many :users, through: :rentals

  def airport_city
    self.city.name + "-" + self.name
  end

end
