class AddRentalReturnColumnToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :rental_return, :datetime
  end
end
