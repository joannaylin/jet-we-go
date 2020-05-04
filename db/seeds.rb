# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Plane.destroy_all
City.destroy_all
Airport.destroy_all
Rental.destroy_all

# planes
Plane.create!(model: "Jet1", identifier: "J1", year_made: 2005, available: true)
Plane.create!(model: "SR-71", identifier: "Blackbird", year_made: 1965, available: true)
Plane.create!(model: "F18", identifier: "Hornets", year_made: 2010, available: true)
Plane.create!(model: "F14", identifier: "Tomcat", year_made: 1989, available: true)

# cities
City.create!(name: "Chicago", destinations: "Millenium Park, The Art Institute, Cloudgate")
City.create!(name: "New York City", destinations: "Times Square, Central Park, Flatiron Building")
City.create!(name: "London", destinations: "Buckingham Palace, Trafalgar's Square")

# airports
Airport.create!(name: "O'Hare Airport", code: "ORD", city_id: 1)
Airport.create!(name: "Midway Airport", code: "MDW", city_id: 1)
Airport.create!(name: "John F Kennedy Airport", code: "JFK", city_id: 2)
Airport.create!(name: "LaGuardia", code: "LGA", city_id: 2)
Airport.create!(name: "Heathrow Airport", code: "LHR", city_id: 3)
Airport.create!(name: "Gatwick Airport", code: "LGW", city_id: 3)

