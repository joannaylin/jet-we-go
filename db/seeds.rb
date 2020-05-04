# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Joanna", password_digest: "bleh")
Plane.create!(model: "Jet1", identifier: "J1", year_made: 2005, available: true)
City.create!(name: "Chicago", destinations: "Millenium Park, The Art Institute, Cloudgate")
Airport.create!(code: "ORD", city_id: 1)
Rental.create!(user_id: 1, plane_id: 1, airport_id: 1, plane_rating: 5)
