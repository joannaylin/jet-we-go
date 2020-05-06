class SetColumnDefaultInRentals < ActiveRecord::Migration[6.0]
  def change
    change_column_default :rentals, :plane_rating, default: 0
  end
end
