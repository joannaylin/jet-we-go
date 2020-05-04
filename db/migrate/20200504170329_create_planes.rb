class CreatePlanes < ActiveRecord::Migration[6.0]
  def change
    create_table :planes do |t|
      t.string :model
      t.string :identifier
      t.integer :year_made
      t.boolean :available

      t.timestamps
    end
  end
end
