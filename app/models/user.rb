class User < ApplicationRecord
  has_secure_password
  has_many :rentals
  has_many :planes, through: :rentals
  has_many :airports, through: :rentals

  # validations
  validates_uniqueness_of :name
  validates_presence_of :password

  def list_rentals
    self.rentals.order(created_at: :desc)
  end

  def next_destinations
    self.rentals.where("rental_start > ?", DateTime.now).where(rental_return: nil).order(rental_start: :asc).limit(1)[0].airport.city.destinations
  end
end
