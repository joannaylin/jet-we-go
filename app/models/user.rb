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
    next_rental = self.rentals.where("rental_start > ?", DateTime.now).where(rental_return: nil).order(rental_start: :asc).limit(1)
    if next_rental.length > 0 
      dest = next_rental[0].airport.city.destinations
    else
      dest = ""
    end
  end

  def next_city
    self.rentals.where("rental_start > ?", DateTime.now).where(rental_return: nil).order(rental_start: :asc).limit(1)[0].airport.city
  end

  def ordered_rentals
    self.rentals.order(:rental_return, :rental_start)
  end

end
