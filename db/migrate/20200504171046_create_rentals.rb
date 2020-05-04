class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :plane, null: false, foreign_key: true
      t.belongs_to :airport, null: false, foreign_key: true
      t.integer :plane_rating

      t.timestamps
    end
  end
end
