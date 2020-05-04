class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports do |t|
      t.string :code
      t.belongs_to :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
