class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :plane
  belongs_to :airport
end
