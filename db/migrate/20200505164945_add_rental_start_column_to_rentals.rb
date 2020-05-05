class AddRentalStartColumnToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :rental_start, :datetime
  end
end
