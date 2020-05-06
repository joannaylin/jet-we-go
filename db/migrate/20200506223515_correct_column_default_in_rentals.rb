class CorrectColumnDefaultInRentals < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:rentals, :plane_rating, from: nil, to: 0)
  end
end
