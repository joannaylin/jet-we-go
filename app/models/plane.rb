class Plane < ApplicationRecord
  has_many :rentals
  has_many :users, through: :rentals
  has_many :airports, through: :rentals
end
