class AddDailyCostColumnToPlanes < ActiveRecord::Migration[6.0]
  def change
    add_column :planes, :daily_cost, :integer
  end
end
