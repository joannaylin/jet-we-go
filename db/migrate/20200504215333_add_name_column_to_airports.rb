class AddNameColumnToAirports < ActiveRecord::Migration[6.0]
  def change
    add_column :airports, :name, :string
  end
end
