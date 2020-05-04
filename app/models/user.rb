class User < ApplicationRecord
  has_secure_password
  has_many :rentals
  has_many :planes, through: :rentals
  has_many :airports, through: :rentals

  # validations
  validates_uniqueness_of :name
  validates_presence_of :password

end
