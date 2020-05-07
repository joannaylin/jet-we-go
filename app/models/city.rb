class City < ApplicationRecord
  has_many :airports

  def self.city_list
    self.order(name: :asc)
  end
end
