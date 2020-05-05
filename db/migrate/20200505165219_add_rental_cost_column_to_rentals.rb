class AddRentalCostColumnToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :rental_cost, :integer
  end
end
